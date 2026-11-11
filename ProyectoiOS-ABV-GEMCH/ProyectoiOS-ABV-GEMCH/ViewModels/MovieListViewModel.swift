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
    private var favoritesQuery = ""

    init(
        destination: Destination,
        movieViewModel: MovieViewModel
    ) {
        self.destination = destination
        self.movieViewModel = movieViewModel
    }

    var isFavoritesScreen: Bool {
        if case .favorites = destination {
            return true
        }

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

    var visibleMovies: [Movie] {
        switch destination {
        case .latest:
            return movieViewModel.movies

        case .results(let query):
            return movieViewModel.search(
                query,
                inList: movieViewModel.movies
            )

        case .favorites, .detail, .favoriteDetail:
            return []
        }
    }

    var visibleFavorites: [MovieFavorite] {
        movieViewModel.searchFavorites(favoritesQuery)
    }

    var emptyMessage: String {
        if isFavoritesScreen &&
            movieViewModel.favoriteMovies.isEmpty {
            return "Aún no tienes películas favoritas guardadas."
        }

        return "No se encontraron películas que coincidan."
    }

    func applyFavoritesSearch(_ text: String) {
        favoritesQuery = text
    }
}
