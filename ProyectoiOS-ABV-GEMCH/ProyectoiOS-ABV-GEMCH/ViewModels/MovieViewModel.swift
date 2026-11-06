//
//  MovieViewModel.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 05/11/26.
//

import Foundation
import Observation

@Observable
class MovieViewModel {
    private let service: MovieService

    let movies: [Movie] = [
        Movie.mockMovieHorizon,
        Movie.mockMovieJourney,
        Movie.mockMovieOpportunity
    ]

    private(set) var favorites: [MovieFavorite] = []
    private(set) var errorMessage: String?

    var favoriteMovies: [MovieFavorite] {
        favorites
    }

    init(service: MovieService) {
        self.service = service
        loadFavorites()
    }

    func loadFavorites() {
        do {
            favorites = try service.fetchFavorites()
            errorMessage = nil
        } catch {
            errorMessage = "No se pudieron cargar tus favoritos."
            print("Error loading favorites: \(error)")
        }
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains { favorite in
            favorite.id == movie.id
        }
    }

    func addFavorite(_ movie: Movie) {
        do {
            try service.addFavorite(movie)
        } catch {
            errorMessage = "No se pudo guardar la película en favoritos."
            print("Error saving favorite: \(error)")
            return
        }

        loadFavorites()
    }

    func removeFavorite(id: Int) {
        do {
            try service.removeFavorite(id: id)
        } catch {
            errorMessage = "No se pudo quitar la película de favoritos."
            print("Error removing favorite: \(error)")
            return
        }

        loadFavorites()
    }

    func toggleFavorite(_ movie: Movie) {
        if isFavorite(movie) {
            removeFavorite(id: movie.id)
        } else {
            addFavorite(movie)
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

    func searchFavorites(_ text: String) -> [MovieFavorite] {
        let query = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !query.isEmpty else {
            return favoriteMovies
        }

        return favoriteMovies.filter { favorite in
            favorite.title.lowercased().contains(query)
        }
    }

    func movie(withID id: Int) -> Movie? {
        movies.first { movie in
            movie.id == id
        }
    }
}
