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

    private let service: movieServices
    private var favoritesQuery = ""

    init(
        destination: Destination,
        service: movieServices
    ) {
        self.destination = destination
        self.service = service
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

        case .detail:
            return "Películas"
        }
    }

    var visibleMovies: [Movie] {
        switch destination {
        case .latest:
            return service.movies

        case .favorites:
            return service.search(
                favoritesQuery,
                inList: service.favoriteMovies
            )

        case .results(let query):
            return service.search(
                query,
                inList: service.movies
            )

        case .detail:
            return []
        }
    }

    var emptyMessage: String {
        if isFavoritesScreen &&
            service.favoriteMovies.isEmpty {
            return "Aún no tienes películas favoritas guardadas."
        }

        return "No se encontraron películas que coincidan."
    }

    func applyFavoritesSearch(_ text: String) {
        favoritesQuery = text
    }
}
