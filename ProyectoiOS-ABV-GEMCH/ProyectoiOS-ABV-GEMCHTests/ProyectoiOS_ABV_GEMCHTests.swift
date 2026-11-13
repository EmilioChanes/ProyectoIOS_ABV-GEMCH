//
//  ProyectoiOS_ABV_GEMCHTests.swift
//  ProyectoiOS-ABV-GEMCHTests
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import Testing
import SwiftData
@testable import ProyectoiOS_ABV_GEMCH

// Crea un servicio con almacenamiento independiente en memoria.
@MainActor
private func makeTestService() throws -> MovieService {
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

    return MovieService(context: context)
}

// Crea el ViewModel compartido utilizando el servicio de prueba.
@MainActor
private func makeTestViewModel() throws -> MovieViewModel {
    let service = try makeTestService()

    return MovieViewModel(service: service)
}

@MainActor
struct MovieViewModelTests {

    @Test(
        "Verifica que toggleFavorite agrega y elimina películas correctamente de favoritos"
    )
    func testToggleFavorite() throws {
        let viewModel = try makeTestViewModel()
        let movie = Movie.mockMovieHorizon

        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.isFavorite(movie) == false)
        #expect(viewModel.favoriteMovies.isEmpty)

        viewModel.toggleFavorite(movie)

        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.isFavorite(movie) == true)
        #expect(viewModel.favoriteMovies.count == 1)
        #expect(viewModel.favoriteMovies.first?.id == movie.id)
        #expect(viewModel.favoriteMovies.first?.title == movie.title)
        #expect(viewModel.favoriteMovies.first?.year == movie.year)

        viewModel.toggleFavorite(movie)

        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.isFavorite(movie) == false)
        #expect(viewModel.favoriteMovies.isEmpty)
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
        let viewModel = try makeTestViewModel()

        let results = viewModel.search(
            query,
            inList: [
                Movie.mockMovieHorizon,
                Movie.mockMovieJourney,
                Movie.mockMovieOpportunity
            ]
        )

        #expect(results.count == expectedCount)
    }
}

@MainActor
struct MovieListViewModelTests {

    @Test("El título se adapta correctamente al Destination")
    func testTitlesForDestinations() throws {
        let movieViewModel = try makeTestViewModel()

        let latestVM = MovieListViewModel(
            destination: .latest,
            movieViewModel: movieViewModel
        )

        #expect(latestVM.title == "Últimas películas")

        let favoritesVM = MovieListViewModel(
            destination: .favorites,
            movieViewModel: movieViewModel
        )

        #expect(favoritesVM.title == "Películas favoritas")

        let resultsVM = MovieListViewModel(
            destination: .results("Batman"),
            movieViewModel: movieViewModel
        )

        #expect(
            resultsVM.title == "Coincidencias con \"Batman\""
        )

        let detailVM = MovieListViewModel(
            destination: .detail(Movie.mockMovieHorizon),
            movieViewModel: movieViewModel
        )

        #expect(detailVM.title == "Películas")
    }

    @Test(
        "Identifica correctamente si la pantalla actual es la de favoritos"
    )
    func testIsFavoritesScreen() throws {
        let movieViewModel = try makeTestViewModel()

        let favoritesVM = MovieListViewModel(
            destination: .favorites,
            movieViewModel: movieViewModel
        )

        #expect(favoritesVM.isFavoritesScreen == true)

        let latestVM = MovieListViewModel(
            destination: .latest,
            movieViewModel: movieViewModel
        )

        #expect(latestVM.isFavoritesScreen == false)
    }

    @Test(
        "La búsqueda dentro de la vista de favoritos filtra la lista visible"
    )
    func testApplyFavoritesSearch() throws {
        let movieViewModel = try makeTestViewModel()
        let movie1 = Movie.mockMovieHorizon
        let movie2 = Movie.mockMovieJourney

        movieViewModel.toggleFavorite(movie1)
        movieViewModel.toggleFavorite(movie2)

        #expect(movieViewModel.errorMessage == nil)

        let viewModel = MovieListViewModel(
            destination: .favorites,
            movieViewModel: movieViewModel
        )

        #expect(viewModel.visibleFavorites.count == 2)

        viewModel.applyFavoritesSearch("viaje")

        #expect(viewModel.visibleFavorites.count == 1)
        #expect(viewModel.visibleFavorites.first?.id == movie2.id)
    }

    @Test(
        "Muestra el mensaje de 'lista vacía' adecuado según el contexto"
    )
    func testEmptyMessages() throws {
        let movieViewModel = try makeTestViewModel()

        #expect(movieViewModel.errorMessage == nil)

        let favoritesVM = MovieListViewModel(
            destination: .favorites,
            movieViewModel: movieViewModel
        )

        #expect(
            favoritesVM.emptyMessage ==
            "Aún no tienes películas favoritas guardadas."
        )

        let resultsVM = MovieListViewModel(
            destination: .results("dsfhjsdf"),
            movieViewModel: movieViewModel
        )

        #expect(
            resultsVM.emptyMessage ==
            "No se encontraron películas que coincidan."
        )
    }
}
