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
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        guard !token.isEmpty else {
            throw TMDBError.missingToken
        }

        guard var components = URLComponents(
            string: baseURL + path
        ) else {
            throw TMDBError.invalidURL
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw TMDBError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw TMDBError.invalidResponse
        }

        guard (200..<300).contains(
            httpResponse.statusCode
        ) else {
            throw TMDBError.httpError(
                httpResponse.statusCode
            )
        }

        return data
    }

    func fetchLatestMovies() async throws -> [Movie] {
        let firstPage = try await fetchLatestMoviesPage(1)
        return firstPage.movies
    }

    func fetchLatestMoviesPage(
        _ page: Int
    ) async throws -> (
        page: Int,
        totalPages: Int,
        movies: [Movie]
    ) {
        let formatter = DateFormatter()

        formatter.locale = Locale(
            identifier: "en_US_POSIX"
        )

        formatter.calendar = Calendar(
            identifier: .gregorian
        )

        formatter.dateFormat = "yyyy-MM-dd"

        let data = try await requestData(
            path: "/discover/movie",
            queryItems: [
                URLQueryItem(
                    name: "language",
                    value: "es-MX"
                ),
                URLQueryItem(
                    name: "page",
                    value: String(page)
                ),
                URLQueryItem(
                    name: "include_adult",
                    value: "false"
                ),
                URLQueryItem(
                    name: "sort_by",
                    value: "primary_release_date.desc"
                ),
                URLQueryItem(
                    name: "with_runtime.gte",
                    value: "31"
                ),
                URLQueryItem(
                    name: "primary_release_date.lte",
                    value: formatter.string(
                        from: Date()
                    )
                )
            ]
        )

        let response = try JSONDecoder().decode(
            TMDBMovieResponse.self,
            from: data
        )

        let movies = try await filterLatestMovies(
            response.results
        )

        return (
            page: response.page,
            totalPages: min(
                response.totalPages,
                500
            ),
            movies: movies
        )
    }

    private func filterLatestMovies(
        _ remoteMovies: [TMDBMovie]
    ) async throws -> [Movie] {
        var movies: [Movie] = []

        for remoteMovie in remoteMovies {
            var movie = try await fetchMovieDetails(
                id: remoteMovie.id
            )

            if let runtime = movie.runtime,
               runtime <= 30 {
                continue
            }

            if hasAnyInformation(movie) {
                movies.append(movie)
                continue
            }

            if let alternativePath = try await fetchMoviePosterPath(
                id: movie.id,
                excluding: movie.posterPath
            ) {
                movie.posterPath = alternativePath
                movies.append(movie)
            }
        }

        return movies
    }

    private func hasAnyInformation(
        _ movie: Movie
    ) -> Bool {
        let hasSynopsis = hasAvailableText(
            movie.synopsis
        )

        let hasClassification = hasAvailableText(
            movie.classification
        )

        let hasCategory = hasAvailableText(
            movie.category
        )

        let hasRuntime = (
            movie.runtime ?? 0
        ) > 0

        let posterPath = movie.posterPath ?? ""

        let hasPoster =
            posterPath.hasPrefix("/") &&
            posterPath.count > 1

        return hasSynopsis ||
               hasClassification ||
               hasCategory ||
               hasRuntime ||
               hasPoster
    }

    private func hasAvailableText(
        _ value: String?
    ) -> Bool {
        guard let value else {
            return false
        }

        let text = value
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .lowercased()

        switch text {
        case "",
             "no disponible",
             "sinopsis no disponible",
             "sinopsis no disponible.",
             "sin sinopsis disponible",
             "sin clasificación disponible",
             "sin categoría disponible":
            return false

        default:
            return true
        }
    }

    func searchMovies(
        _ text: String
    ) async throws -> [Movie] {
        let query = text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !query.isEmpty else {
            return []
        }

        let data = try await requestData(
            path: "/search/movie",
            queryItems: [
                URLQueryItem(
                    name: "query",
                    value: query
                ),
                URLQueryItem(
                    name: "language",
                    value: "es-MX"
                ),
                URLQueryItem(
                    name: "page",
                    value: "1"
                ),
                URLQueryItem(
                    name: "include_adult",
                    value: "false"
                )
            ]
        )

        let response = try JSONDecoder().decode(
            TMDBMovieResponse.self,
            from: data
        )

        return response.results.map {
            $0.toMovie()
        }
    }

    func fetchMovieDetails(
        id: Int
    ) async throws -> Movie {
        guard id > 0 else {
            throw TMDBError.invalidMovieID
        }

        let data = try await requestData(
            path: "/movie/\(id)",
            queryItems: [
                URLQueryItem(
                    name: "language",
                    value: "es-MX"
                ),
                URLQueryItem(
                    name: "append_to_response",
                    value: "credits,release_dates"
                )
            ]
        )

        let decoder = JSONDecoder()

        let movie = try decoder.decode(
            TMDBMovie.self,
            from: data
        )

        let extras = try decoder.decode(
            TMDBMovieExtras.self,
            from: data
        )

        let crew = extras.credits?.crew ?? []
        let cast = extras.credits?.cast ?? []

        return movie.toMovie(
            classification: movieClassification(
                from: extras.releaseDates
            ) ?? "No disponible",
            directors: crew
                .filter {
                    $0.job == "Director"
                }
                .map {
                    $0.name
                },
            cast: cast.map {
                $0.name
            }
        )
    }

    private func movieClassification(
        from releases: TMDBReleaseDatesResponse?
    ) -> String? {
        let mexico = releases?.results.first {
            $0.countryCode == "MX"
        }

        let certifications = (
            mexico?.releaseDates ?? []
        )
        .filter {
            !$0.certification
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
                .isEmpty
        }

        let classification = certifications.first {
            $0.type == 3
        }?.certification
            ?? certifications.first?.certification

        return classification?.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }

    func fetchMoviePosterPath(
        id: Int,
        excluding excludedPath: String?
    ) async throws -> String? {
        guard id > 0 else {
            return nil
        }

        let data = try await requestData(
            path: "/movie/\(id)/images"
        )

        let images = try JSONDecoder().decode(
            TMDBMovieImages.self,
            from: data
        )

        return (
            images.posters + images.backdrops
        )
        .map {
            $0.filePath
        }
        .first {
            $0.hasPrefix("/") &&
            $0.count > 1 &&
            $0 != excludedPath
        }
    }
}

private struct TMDBMovieExtras: Decodable {
    let credits: TMDBCreditsResponse?
    let releaseDates: TMDBReleaseDatesResponse?

    enum CodingKeys: String, CodingKey {
        case credits
        case releaseDates = "release_dates"
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
