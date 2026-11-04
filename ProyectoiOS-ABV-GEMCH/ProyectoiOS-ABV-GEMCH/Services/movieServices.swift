//
//  Pelicula.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import Foundation
import Observation
import SwiftData

@Observable
class movieServices {
    let movies: [Movie] = [
        Movie.mockMovieHorizon,
        Movie.mockMovieJourney,
        Movie.mockMovieOpportunity
    ]

    private let context: ModelContext

    private(set) var favorites: [Movie] = []
    private(set) var errorMessage: String?

    var favoriteMovies: [Movie] {
        favorites
    }

    init(context: ModelContext) {
        self.context = context
        loadFavorites()
    }

    func loadFavorites() {
        do {
            let savedMovies = try context.fetch(
                FetchDescriptor<SavedMovie>()
            )

            favorites = savedMovies.map { savedMovie in
                movieForDisplay(savedMovie)
            }

            errorMessage = nil
        } catch {
            errorMessage = "No se pudieron cargar tus favoritos."
            print("Error loading favorites: \(error)")
        }
    }

    private func movieForDisplay(
        _ savedMovie: SavedMovie
    ) -> Movie {
        if let movie = movies.first(where: { movie in
            movie.id == savedMovie.id
        }) {
            return movie
        }

        return Movie(
            id: savedMovie.id,
            title: savedMovie.title,
            year: savedMovie.year,
            classification: "No disponible",
            category: "No disponible",
            director: "No disponible",
            synopsis: """
            Esta película está guardada en favoritos, pero sus \
            detalles no están disponibles en el catálogo actual.
            """,
            cast: []
        )
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains { favorite in
            favorite.id == movie.id
        }
    }

    func addFavorite(_ movie: Movie) {
        do {
            let savedMovies = try context.fetch(
                FetchDescriptor<SavedMovie>()
            )

            let alreadySaved = savedMovies.contains { savedMovie in
                savedMovie.id == movie.id
            }

            guard !alreadySaved else {
                loadFavorites()
                return
            }

            let savedMovie = SavedMovie(
                id: movie.id,
                title: movie.title,
                year: movie.year
            )

            context.insert(savedMovie)
            try context.save()

            loadFavorites()
        } catch {
            context.rollback()
            errorMessage = "No se pudo guardar la película en favoritos."
            print("Error saving favorite: \(error)")
        }
    }

    func removeFavorite(_ movie: Movie) {
        do {
            let savedMovies = try context.fetch(
                FetchDescriptor<SavedMovie>()
            )

            let matchingMovies = savedMovies.filter { savedMovie in
                savedMovie.id == movie.id
            }

            for savedMovie in matchingMovies {
                context.delete(savedMovie)
            }

            try context.save()

            loadFavorites()
        } catch {
            context.rollback()
            errorMessage = "No se pudo quitar la película de favoritos."
            print("Error removing favorite: \(error)")
        }
    }

    func toggleFavorite(_ movie: Movie) {
        if isFavorite(movie) {
            removeFavorite(movie)
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
}