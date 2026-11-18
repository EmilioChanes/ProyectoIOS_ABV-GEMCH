//
//  MovieListViewModel.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//

import Observation

@Observable
class MovieListViewModel {
    let destination: Destination

    private let movieViewModel: MovieViewModel
    private let tmdbService = TMDBService()
    private var favoritesQuery = ""
    private var hasLoadedResults = false

    private(set) var visibleMovies: [Movie] = []
    private(set) var isLoading = false
    private(set) var loadingErrorMessage: String?
    private(set) var currentPage: Int?
    private(set) var totalPages = 0

    init(destination: Destination, movieViewModel: MovieViewModel) {
        self.destination = destination
        self.movieViewModel = movieViewModel
    }

    var isFavoritesScreen: Bool {
        if case .favorites = destination { return true }
        return false
    }

    var isLatestScreen: Bool {
        if case .latest = destination { return true }
        return false
    }

    var title: String {
        switch destination {
        case .latest:
            return "Últimas películas"
        case .favorites:
            return "Películas favoritas"
        case .results(let query):
            return "Coincidencias con \"\(query)\""
        case .detail, .favoriteDetail:
            return "Películas"
        }
    }

    var visibleFavorites: [MovieFavorite] {
        movieViewModel.searchFavorites(favoritesQuery)
    }

    var emptyMessage: String {
        if isFavoritesScreen && movieViewModel.favoriteMovies.isEmpty {
            return "Aún no tienes películas favoritas guardadas."
        }

        if isLatestScreen {
            return "No hay películas disponibles."
        }

        return "No se encontraron películas que coincidan."
    }

    func applyFavoritesSearch(_ text: String) {
        favoritesQuery = text
    }

    @MainActor
    func loadMovies() async {
        switch destination {
        case .latest:
            if currentPage == nil {
                await loadPage(1)
            }

        case .results(let query):
            guard !isLoading, !hasLoadedResults else { return }

            isLoading = true
            loadingErrorMessage = nil
            defer { isLoading = false }

            do {
                let results = try await tmdbService.searchMovies(query)
                guard !Task.isCancelled else { return }

                visibleMovies = results
                hasLoadedResults = true
            } catch {
                if !Task.isCancelled {
                    loadingErrorMessage = "No se pudieron obtener los resultados."
                    print("Error al buscar películas:", error)
                }
            }

        case .favorites, .detail, .favoriteDetail:
            break
        }
    }

    @MainActor
    func loadPage(_ page: Int) async {
        guard isLatestScreen, !isLoading,
              page >= 1, page <= max(1, totalPages) else {
            return
        }

        isLoading = true
        loadingErrorMessage = nil
        defer { isLoading = false }

        do {
            let result = try await tmdbService.fetchLatestMoviesPage(page)
            guard !Task.isCancelled else { return }

            visibleMovies = result.movies
            totalPages = result.totalPages
            currentPage = result.page
        } catch {
            if !Task.isCancelled {
                loadingErrorMessage = "No se pudo cargar la página \(page)."
                print("Error al cargar la página \(page):", error)
            }
        }
    }
}
