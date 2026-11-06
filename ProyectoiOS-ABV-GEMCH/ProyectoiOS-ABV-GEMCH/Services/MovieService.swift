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
        let savedMovies = try context.fetch(
            FetchDescriptor<SavedMovie>()
        )

        return savedMovies.map { savedMovie in
            MovieFavorite(
                id: savedMovie.id,
                title: savedMovie.title,
                year: savedMovie.year
            )
        }
    }

    func addFavorite(_ movie: Movie) throws {
        let savedMovies = try context.fetch(
            FetchDescriptor<SavedMovie>()
        )

        let alreadySaved = savedMovies.contains { savedMovie in
            savedMovie.id == movie.id
        }

        guard !alreadySaved else {
            return
        }

        let savedMovie = SavedMovie(
            id: movie.id,
            title: movie.title,
            year: movie.year
        )

        context.insert(savedMovie)

        do {
            try context.save()
        } catch {
            context.rollback()
            throw error
        }
    }

    func removeFavorite(id: Int) throws {
        let savedMovies = try context.fetch(
            FetchDescriptor<SavedMovie>()
        )

        let matchingMovies = savedMovies.filter { savedMovie in
            savedMovie.id == id
        }

        for savedMovie in matchingMovies {
            context.delete(savedMovie)
        }

        do {
            try context.save()
        } catch {
            context.rollback()
            throw error
        }
    }
}
