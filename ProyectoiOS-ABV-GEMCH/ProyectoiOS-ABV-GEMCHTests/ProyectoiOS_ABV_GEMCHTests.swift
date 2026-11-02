//
//  ProyectoiOS_ABV_GEMCHTests.swift
//  ProyectoiOS-ABV-GEMCHTests
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import Testing
@testable import ProyectoiOS_ABV_GEMCH

struct MovieServicesTests {

    // Probar el flujo completo de agregar y quitar favoritos
    @Test("Verifica que toggleFavorite agrega y elimina películas correctamente de favoritos")
    func testToggleFavorite() {
        let service = movieServices()
        let movie = Movie.mockMovieHorizon
        
        #expect(service.isFavorite(movie) == false)
        #expect(service.favoriteMovies.isEmpty)
        
        service.toggleFavorite(movie)
        
        #expect(service.isFavorite(movie) == true)
        #expect(service.favoriteMovies.count == 1)
        #expect(service.favoriteMovies.first == movie)
        
        service.toggleFavorite(movie)
        
        #expect(service.isFavorite(movie) == false)
        #expect(service.favoriteMovies.isEmpty)
    }

    // Prueba parametrizada para comprobar el motor de búsqueda interno
    @Test("El buscador filtra películas sin importar mayúsculas o espacios", arguments: [
        ("horizonte", 1),         
        ("  HORIZONTE  ", 1),     
        ("viaje", 1),             
        ("desconocido", 0),       
        ("", 3)                   
    ])
    func testSearch(query: String, expectedCount: Int) {
        let service = movieServices()
        let results = service.search(query, inList: service.movies)
        
        #expect(results.count == expectedCount)
    }
}

struct MovieListViewModelTests {

    // Verificar que el ViewModel genere el título correcto según el destino
    @Test("El título se adapta correctamente al Destination")
    func testTitlesForDestinations() {
        let service = movieServices()
        
        let latestVM = MovieListViewModel(destination: .latest, service: service)
        #expect(latestVM.title == "Últimas películas")
        
        let favoritesVM = MovieListViewModel(destination: .favorites, service: service)
        #expect(favoritesVM.title == "Películas favoritas")
        
        let resultsVM = MovieListViewModel(destination: .results("Batman"), service: service)
        #expect(resultsVM.title == "Coincidencias con \"Batman\"")
        
        let detailVM = MovieListViewModel(destination: .detail(Movie.mockMovieHorizon), service: service)
        #expect(detailVM.title == "Películas")
    }

    // Verificar la bandera booleana que activa la barra de búsqueda de favoritos
    @Test("Identifica correctamente si la pantalla actual es la de favoritos")
    func testIsFavoritesScreen() {
        let service = movieServices()
        
        let favoritesVM = MovieListViewModel(destination: .favorites, service: service)
        #expect(favoritesVM.isFavoritesScreen == true)
        
        let latestVM = MovieListViewModel(destination: .latest, service: service)
        #expect(latestVM.isFavoritesScreen == false)
    }
    
    // Verificar que el buscador local dentro de la vista de favoritos funcione bien
    @Test("La búsqueda dentro de la vista de favoritos filtra la lista visible")
    func testApplyFavoritesSearch() {
        let service = movieServices()
        let movie1 = Movie.mockMovieHorizon
        let movie2 = Movie.mockMovieJourney
        
        service.toggleFavorite(movie1)
        service.toggleFavorite(movie2)
        
        let viewModel = MovieListViewModel(destination: .favorites, service: service)
        
        #expect(viewModel.visibleMovies.count == 2)
        
        viewModel.applyFavoritesSearch("viaje")
        
        #expect(viewModel.visibleMovies.count == 1)
        #expect(viewModel.visibleMovies.first == movie2)
    }
    
    // Verificar los mensajes dinámicos de estado vacío
    @Test("Muestra el mensaje de 'lista vacía' adecuado según el contexto")
    func testEmptyMessages() {
        let service = movieServices()
        
        let favoritesVM = MovieListViewModel(destination: .favorites, service: service)
        #expect(favoritesVM.emptyMessage == "Aún no tienes películas favoritas guardadas.")
        
        let resultsVM = MovieListViewModel(destination: .results("dsfhjsdf"), service: service)
        #expect(resultsVM.emptyMessage == "No se encontraron películas que coincidan.")
    }
}