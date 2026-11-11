//
//  ContentView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var movieViewModel: MovieViewModel
    @State private var path: [Destination] = []

    init(context: ModelContext) {
        let service = MovieService(context: context)

        _movieViewModel = State(
            initialValue: MovieViewModel(service: service)
        )
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    HeaderView(path: $path)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Últimas películas")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            NavigationLink(
                                "Ver más",
                                value: Destination.latest
                            )
                        }
                        
                        ScrollView(.horizontal) {
                            HStack(alignment: .top, spacing: 16) {
                                ForEach(
                                    movieViewModel.movies,
                                    id: \.id
                                ) { movie in
                                    MovieCardView(
                                        movie: movie
                                    )
                                    .frame(width: 180)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Películas favoritas")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            NavigationLink(
                                "Ver más",
                                value: Destination.favorites
                            )
                        }
                        
                        if movieViewModel.favoriteMovies.isEmpty {
                            Text(
                                "Aún no tienes películas favoritas guardadas..."
                            )
                            .foregroundStyle(.secondary)
                        } else {
                            ScrollView(.horizontal) {
                                HStack(
                                    alignment: .top,
                                    spacing: 16
                                ) {
                                    ForEach(
                                        movieViewModel.favoriteMovies,
                                        id: \.id
                                    ) { favorite in
                                        MovieFavoriteCardView(
                                            favorite: favorite
                                        )
                                        .frame(width: 180)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .latest:
                    MovieListView(
                        destination: destination,
                        movieViewModel: movieViewModel,
                        path: $path
                    )
                    
                case .favorites:
                    MovieListView(
                        destination: destination,
                        movieViewModel: movieViewModel,
                        path: $path
                    )
                    
                case .results:
                    MovieListView(
                        destination: destination,
                        movieViewModel: movieViewModel,
                        path: $path
                    )
                    
                case .detail(let movie):
                    MovieDetailView(
                        movie: movie,
                        path: $path
                    )
                case .favoriteDetail(let favorite):
                    if let movie = movieViewModel.movie(withID: favorite.id) {
                        MovieDetailView(
                            movie: movie,
                            path: $path
                        )
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                HeaderView(
                                    path: $path,
                                    showSearchBar: false,
                                    showHero: false
                                )

                                VStack(alignment: .leading, spacing: 16) {
                                    Text(favorite.title)
                                        .font(.largeTitle)
                                        .bold()

                                    Text("Año de estreno: \(favorite.year)")

                                    Text(
                                        "Los detalles de esta película no están disponibles."
                                    )
                                    .foregroundStyle(.secondary)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        .environment(movieViewModel)
    }
}

#Preview {
    let schema = Schema([
        SavedMovie.self
    ])

    let configuration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: true
    )

    let container = try! ModelContainer(
        for: schema,
        configurations: [configuration]
    )

    let context = ModelContext(container)

    ContentView(context: context)
}
