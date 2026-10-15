//
//  Pelicula.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import Observation
import Foundation

@Observable
class movieServices {
    let movies: [Movie] = [
        Movie.mockMovieHorizon,
        Movie.mockMovieJourney,
        Movie.mockMovieOpportunity
    ]

    var favorites: [Movie] = []

    var favoriteMovies: [Movie] {
        favorites
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains { favorite in
            favorite.id == movie.id
        }
    }

    func toggleFavorite(_ movie: Movie) {
        if isFavorite(movie) {
            favorites.removeAll { favorite in
                favorite.id == movie.id
            }
        } else {
            favorites.append(movie)
        }
    }

    func search(
        _ text: String,
        inList list: [Movie]
    ) -> [Movie] {
        let query = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !query.isEmpty else {
            return list
        }

        return list.filter { movie in
            movie.title.lowercased().contains(query)
        }
    }
}
