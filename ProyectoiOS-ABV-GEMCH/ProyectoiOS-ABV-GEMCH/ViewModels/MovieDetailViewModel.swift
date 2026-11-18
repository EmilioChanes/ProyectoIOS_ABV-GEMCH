//
//  MovieDetailViewModel.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 12/11/26.
//

import Observation

@Observable
class MovieDetailViewModel {
    private let movieID: Int
    private let tmdbService = TMDBService()

    private(set) var movie: Movie?
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    init(movieID: Int) {
        self.movieID = movieID
    }

    @MainActor
    func loadMovie() async {
        guard !isLoading, movie == nil else {
            return
        }

        errorMessage = nil

        if movieID <= 0 {
            let sampleMovies = [
                Movie.mockMovieHorizon,
                Movie.mockMovieJourney,
                Movie.mockMovieOpportunity
            ]
            movie = sampleMovies.first { $0.id == movieID }

            if movie == nil {
                errorMessage = "Los detalles de esta película no están disponibles."
            }
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await tmdbService.fetchMovieDetails(id: movieID)

            if !Task.isCancelled {
                movie = result
            }
        } catch {
            if !Task.isCancelled {
                errorMessage = "No se pudieron cargar los detalles de la película."
                print("Error al cargar detalle:", error)
            }
        }
    }
}
