//
//  ProyectoiOS_ABV_GEMCHTests.swift
//  ProyectoiOS-ABV-GEMCHTests
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import Testing
import SwiftData
@testable import ProyectoiOS_ABV_GEMCH

@MainActor
private func makeTestService() throws -> movieServices {
    let schema = Schema([
        SavedMovie.self
    ])

    let configuration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: true
    )

    let container = try ModelContainer(
        for: schema,
        configurations: [configuration]
    )

    let context = ModelContext(container)

    return movieServices(context: context)
}

@MainActor
struct MovieServicesTests {

    @Test(
        "Verifica que toggleFavorite agrega y elimina películas correctamente de favoritos"
    )
    func testToggleFavorite() throws {
        let service = try makeTestService()
        let movie = Movie.mockMovieHorizon

        #expect(service.isFavorite(movie) == false)
        #expect(service.favoriteMovies.isEmpty)

        service.toggleFavorite(movie)

        #expect(service.errorMessage == nil)
        #expect(service.isFavorite(movie) == true)
        #expect(service.favoriteMovies.count == 1)
        #expect(service.favoriteMovies.first == movie)

        service.toggleFavorite(movie)

        #expect(service.errorMessage == nil)
        #expect(service.isFavorite(movie) == false)
        #expect(service.favoriteMovies.isEmpty)
    }

    @Test(
        "El buscador filtra películas sin importar mayúsculas o espacios",
        arguments: [
            ("horizonte", 1),
            ("  HORIZONTE  ", 1),
            ("viaje", 1),
            ("desconocido", 0),
            ("", 3)
        ]
    )
    func testSearch(
        query: String,
        expectedCount: Int
    ) throws {
        let service = try makeTestService()

        let results = service.search(
            query,
            inList: service.movies
        )

        #expect(results.count == expectedCount)
    }
}

@MainActor
struct MovieListViewModelTests {

    @Test("El título se adapta correctamente al Destination")
    func testTitlesForDestinations() throws {
        let service = try makeTestService()

        let latestVM = MovieListViewModel(
            destination: .latest,
            service: service
        )

        #expect(latestVM.title == "Últimas películas")

        let favoritesVM = MovieListViewModel(
            destination: .favorites,
            service: service
        )

        #expect(favoritesVM.title == "Películas favoritas")

        let resultsVM = MovieListViewModel(
            destination: .results("Batman"),
            service: service
        )

        #expect(
            resultsVM.title == "Coincidencias con \"Batman\""
        )

        let detailVM = MovieListViewModel(
            destination: .detail(Movie.mockMovieHorizon),
            service: service
        )

        #expect(detailVM.title == "Películas")
    }

    @Test(
        "Identifica correctamente si la pantalla actual es la de favoritos"
    )
    func testIsFavoritesScreen() throws {
        let service = try makeTestService()

        let favoritesVM = MovieListViewModel(
            destination: .favorites,
            service: service
        )

        #expect(favoritesVM.isFavoritesScreen == true)

        let latestVM = MovieListViewModel(
            destination: .latest,
            service: service
        )

        #expect(latestVM.isFavoritesScreen == false)
    }

    @Test(
        "La búsqueda dentro de la vista de favoritos filtra la lista visible"
    )
    func testApplyFavoritesSearch() throws {
        let service = try makeTestService()
        let movie1 = Movie.mockMovieHorizon
        let movie2 = Movie.mockMovieJourney

        service.toggleFavorite(movie1)
        service.toggleFavorite(movie2)

        #expect(service.errorMessage == nil)

        let viewModel = MovieListViewModel(
            destination: .favorites,
            service: service
        )

        #expect(viewModel.visibleMovies.count == 2)

        viewModel.applyFavoritesSearch("viaje")

        #expect(viewModel.visibleMovies.count == 1)
        #expect(viewModel.visibleMovies.first == movie2)
    }

    @Test(
        "Muestra el mensaje de 'lista vacía' adecuado según el contexto"
    )
    func testEmptyMessages() throws {
        let service = try makeTestService()

        let favoritesVM = MovieListViewModel(
            destination: .favorites,
            service: service
        )

        #expect(
            favoritesVM.emptyMessage ==
            "Aún no tienes películas favoritas guardadas."
        )

        let resultsVM = MovieListViewModel(
            destination: .results("dsfhjsdf"),
            service: service
        )

        #expect(
            resultsVM.emptyMessage ==
            "No se encontraron películas que coincidan."
        )
    }
}
