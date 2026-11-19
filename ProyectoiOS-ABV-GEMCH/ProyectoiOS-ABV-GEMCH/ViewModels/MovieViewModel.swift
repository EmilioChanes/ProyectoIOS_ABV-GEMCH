//
//  MovieViewModel.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import Foundation
import Observation

@Observable
class MovieViewModel {
    private let service: MovieService
    private let tmdbService = TMDBService()

    private(set) var movies: [Movie] = []
    private(set) var isLoadingMovies = false
    private(set) var moviesErrorMessage: String?
    private var hasLoadedMovies = false

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
            print("Error al cargar favoritos:", error)
        }
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains { $0.id == movie.id }
    }

    func addFavorite(_ movie: Movie) {
        do {
            try service.addFavorite(movie)
            loadFavorites()
        } catch {
            errorMessage = "No se pudo guardar la película en favoritos."
            print("Error al guardar favorito:", error)
        }
    }

    func removeFavorite(id: Int) {
        do {
            try service.removeFavorite(id: id)
            loadFavorites()
        } catch {
            errorMessage = "No se pudo quitar la película de favoritos."
            print("Error al quitar favorito:", error)
        }
    }

    func toggleFavorite(_ movie: Movie) {
        if isFavorite(movie) {
            removeFavorite(id: movie.id)
        } else {
            addFavorite(movie)
        }
    }

    func search(_ text: String, inList list: [Movie]) -> [Movie] {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !query.isEmpty else {
            return list
        }

        return list.filter { $0.title.lowercased().contains(query) }
    }

    func searchFavorites(_ text: String) -> [MovieFavorite] {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !query.isEmpty else {
            return favoriteMovies
        }

        return favoriteMovies.filter { $0.title.lowercased().contains(query) }
    }

    @MainActor
    func loadLatestMovies() async {
        guard !isLoadingMovies, !hasLoadedMovies else {
            return
        }

        isLoadingMovies = true
        moviesErrorMessage = nil
        defer { isLoadingMovies = false }

        do {
            let result = try await tmdbService.fetchLatestMovies()

            guard !Task.isCancelled else {
                return
            }

            movies = result
            hasLoadedMovies = true
        } catch {
            if !Task.isCancelled {
                moviesErrorMessage = "No se pudieron cargar las películas."
                print("Error al cargar películas:", error)
            }
        }
    }

    @MainActor
    func findAlternativePoster(
        movieID: Int,
        excluding path: String?
    ) async -> String? {
        guard movieID > 0, !Task.isCancelled else {
            return nil
        }

        do {
            let alternative = try await tmdbService.fetchMoviePosterPath(
                id: movieID,
                excluding: path
            )

            if alternative == nil && !Task.isCancelled {
                print("Portada | ID \(movieID) | TMDB no devolvió otra imagen")
            }

            return alternative
        } catch {
            if !Task.isCancelled {
                print("Portada | ID \(movieID) | Error al buscar otra imagen:", error)
            }
            return nil
        }
    }

    func saveRecoveredPoster(movieID: Int, posterPath: String) {
        guard let favorite = favorites.first(where: { $0.id == movieID }),
              favorite.posterPath != posterPath else {
            return
        }

        do {
            try service.updateFavoritePoster(id: movieID, posterPath: posterPath)
            loadFavorites()
        } catch {
            print("Portada | ID \(movieID) | No se pudo guardar la ruta:", error)
        }
    }
}
