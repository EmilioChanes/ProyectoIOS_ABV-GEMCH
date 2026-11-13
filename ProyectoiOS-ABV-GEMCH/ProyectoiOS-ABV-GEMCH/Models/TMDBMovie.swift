//
//  TMDBMovie.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 12/11/26.
//

struct TMDBMovie: Decodable {
    let id: Int
    let title: String
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let voteAverage: Double?
    let genres: [TMDBGenre]?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }

    func toMovie(
        classification: String = "No disponible",
        directors: [String] = [],
        cast: [String] = []
    ) -> Movie {
        let categories = (genres ?? []).map { $0.name }
        let synopsis = overview ?? ""

        return Movie(
            id: id,
            title: title,
            year: String((releaseDate ?? "").prefix(4)),
            classification: classification,
            category: categories.isEmpty
                ? "No disponible"
                : categories.joined(separator: ", "),
            director: directors.isEmpty
                ? "No disponible"
                : directors.joined(separator: ", "),
            synopsis: synopsis.isEmpty ? "Sinopsis no disponible." : synopsis,
            cast: cast,
            rating: voteAverage,
            posterPath: posterPath
        )
    }
}

struct TMDBGenre: Decodable {
    let name: String
}

struct TMDBMovieResponse: Decodable {
    let page: Int
    let results: [TMDBMovie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}
struct TMDBCreditsResponse: Decodable {
    let cast: [TMDBCastMember]
    let crew: [TMDBCrewMember]
}

struct TMDBCastMember: Decodable {
    let name: String
}

struct TMDBCrewMember: Decodable {
    let name: String
    let job: String
}

struct TMDBReleaseDatesResponse: Decodable {
    let results: [TMDBCountryRelease]
}

struct TMDBCountryRelease: Decodable {
    let countryCode: String
    let releaseDates: [TMDBReleaseEntry]

    enum CodingKeys: String, CodingKey {
        case countryCode = "iso_3166_1"
        case releaseDates = "release_dates"
    }
}

struct TMDBReleaseEntry: Decodable {
    let certification: String
    let type: Int
}
