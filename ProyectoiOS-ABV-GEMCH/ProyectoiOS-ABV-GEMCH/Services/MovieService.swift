//
//  Pelicula.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import SwiftData

class MovieService {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchFavorites() throws -> [MovieFavorite] {
        let savedMovies = try context.fetch(FetchDescriptor<SavedMovie>())

        return savedMovies.map {
            MovieFavorite(
                id: $0.id,
                title: $0.title,
                year: $0.year,
                posterPath: $0.posterPath
            )
        }
    }

    func addFavorite(_ movie: Movie) throws {
        let savedMovies = try context.fetch(FetchDescriptor<SavedMovie>())

        guard !savedMovies.contains(where: { $0.id == movie.id }) else {
            return
        }

        context.insert(
            SavedMovie(
                id: movie.id,
                title: movie.title,
                year: movie.year,
                posterPath: movie.posterPath
            )
        )
        try saveChanges()
    }

    func removeFavorite(id: Int) throws {
        let savedMovies = try context.fetch(FetchDescriptor<SavedMovie>())

        for savedMovie in savedMovies where savedMovie.id == id {
            context.delete(savedMovie)
        }

        try saveChanges()
    }

    func updateFavoritePoster(id: Int, posterPath: String) throws {
        let savedMovies = try context.fetch(FetchDescriptor<SavedMovie>())

        guard let savedMovie = savedMovies.first(where: { $0.id == id }) else {
            return
        }

        savedMovie.posterPath = posterPath
        try saveChanges()
    }

    private func saveChanges() throws {
        do {
            try context.save()
        } catch {
            context.rollback()
            throw error
        }
    }
}
