//
//  TMDBService.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 12/11/26.
//

import Foundation

enum TMDBError: Error {
    case missingToken
    case invalidURL
    case invalidResponse
    case invalidMovieID
    case httpError(Int)
}

class TMDBService {
    private let baseURL = "https://api.themoviedb.org/3"

    private func requestData(
        path: String,
        queryItems: [URLQueryItem] = []
    ) async throws -> Data {
        let token = Secrets.token.rawValue
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !token.isEmpty else {
            throw TMDBError.missingToken
        }

        guard var components = URLComponents(string: baseURL + path) else {
            throw TMDBError.invalidURL
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw TMDBError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw TMDBError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw TMDBError.httpError(httpResponse.statusCode)
        }

        return data
    }

    func fetchLatestMovies() async throws -> [Movie] {
        let firstPage = try await fetchLatestMoviesPage(1)
        return firstPage.movies
    }

    func fetchLatestMoviesPage(
        _ page: Int
    ) async throws -> (page: Int, totalPages: Int, movies: [Movie]) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"

        let data = try await requestData(
            path: "/discover/movie",
            queryItems: [
                URLQueryItem(name: "language", value: "es-MX"),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "sort_by", value: "primary_release_date.desc"),
                URLQueryItem(
                    name: "primary_release_date.lte",
                    value: formatter.string(from: Date())
                )
            ]
        )

        let response = try JSONDecoder().decode(TMDBMovieResponse.self, from: data)

        return (
            page: response.page,
            totalPages: min(response.totalPages, 500),
            movies: response.results.map { $0.toMovie() }
        )
    }

    func searchMovies(_ text: String) async throws -> [Movie] {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return []
        }

        let data = try await requestData(
            path: "/search/movie",
            queryItems: [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "language", value: "es-MX"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "include_adult", value: "false")
            ]
        )

        let response = try JSONDecoder().decode(TMDBMovieResponse.self, from: data)
        return response.results.map { $0.toMovie() }
    }

    private func fetchMovie(id: Int) async throws -> TMDBMovie {
        guard id > 0 else {
            throw TMDBError.invalidMovieID
        }

        let data = try await requestData(
            path: "/movie/\(id)",
            queryItems: [URLQueryItem(name: "language", value: "es-MX")]
        )

        return try JSONDecoder().decode(TMDBMovie.self, from: data)
    }

    func fetchMoviePosterPath(
        id: Int,
        excluding excludedPath: String?
    ) async throws -> String? {
        guard id > 0 else {
            return nil
        }

        let data = try await requestData(path: "/movie/\(id)/images")
        let images = try JSONDecoder().decode(TMDBMovieImages.self, from: data)

        return (images.posters + images.backdrops)
            .map { $0.filePath }
            .first {
                $0.hasPrefix("/") && $0.count > 1 && $0 != excludedPath
            }
    }

    func fetchMovieDetails(id: Int) async throws -> Movie {
        let movie = try await fetchMovie(id: id)

        let creditsData = try await requestData(
            path: "/movie/\(id)/credits",
            queryItems: [URLQueryItem(name: "language", value: "es-MX")]
        )
        let credits = try JSONDecoder().decode(TMDBCreditsResponse.self, from: creditsData)

        let releasesData = try await requestData(path: "/movie/\(id)/release_dates")
        let releases = try JSONDecoder().decode(
            TMDBReleaseDatesResponse.self,
            from: releasesData
        )

        let mexico = releases.results.first { $0.countryCode == "MX" }
        let certifications = (mexico?.releaseDates ?? []).filter {
            !$0.certification.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }

        let classification = certifications.first { $0.type == 3 }?.certification
            ?? certifications.first?.certification
            ?? "No disponible"

        return movie.toMovie(
            classification: classification,
            directors: credits.crew.filter { $0.job == "Director" }.map { $0.name },
            cast: credits.cast.map { $0.name }
        )
    }
}

private struct TMDBMovieImages: Decodable {
    let posters: [TMDBImagePath]
    let backdrops: [TMDBImagePath]
}

private struct TMDBImagePath: Decodable {
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
