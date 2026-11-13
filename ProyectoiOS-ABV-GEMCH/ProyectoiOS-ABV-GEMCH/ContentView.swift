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
        _movieViewModel = State(initialValue: MovieViewModel(service: service))
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    HeaderView(path: $path, showHomeButton: false)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Últimas películas")
                                .font(.title2)
                                .bold()

                            Spacer()

                            NavigationLink("Ver más", value: Destination.latest)
                        }

                        if movieViewModel.isLoadingMovies {
                            ProgressView("Cargando películas...")
                        } else if let message = movieViewModel.moviesErrorMessage {
                            Text(message)
                                .foregroundStyle(.red)
                        } else if movieViewModel.movies.isEmpty {
                            Text("No hay películas disponibles.")
                                .foregroundStyle(.secondary)
                        } else {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top, spacing: 16) {
                                    ForEach(movieViewModel.movies.prefix(20), id: \.id) { movie in
                                        MovieCardView(movie: movie)
                                            .frame(width: 180)
                                    }
                                }
                            }
                        }

                        HStack {
                            Text("Películas favoritas")
                                .font(.title2)
                                .bold()

                            Spacer()

                            NavigationLink("Ver más", value: Destination.favorites)
                        }

                        if movieViewModel.favoriteMovies.isEmpty {
                            Text("Aún no tienes películas favoritas guardadas...")
                                .foregroundStyle(.secondary)
                        } else {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top, spacing: 16) {
                                    ForEach(
                                        movieViewModel.favoriteMovies.prefix(20),
                                        id: \.id
                                    ) { favorite in
                                        MovieFavoriteCardView(favorite: favorite)
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
                case .latest, .favorites, .results:
                    MovieListView(
                        destination: destination,
                        movieViewModel: movieViewModel,
                        path: $path
                    )

                case .detail(let movie):
                    MovieDetailView(
                        movieID: movie.id,
                        title: movie.title,
                        year: movie.year,
                        posterPath: movie.posterPath,
                        path: $path
                    )

                case .favoriteDetail(let favorite):
                    MovieDetailView(
                        movieID: favorite.id,
                        title: favorite.title,
                        year: favorite.year,
                        posterPath: favorite.posterPath,
                        path: $path
                    )
                }
            }
        }
        .environment(movieViewModel)
        .task {
            await movieViewModel.loadLatestMovies()
        }
    }
}

#Preview {
    let schema = Schema([SavedMovie.self])
    let configuration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: true
    )
    let container = try! ModelContainer(
        for: schema,
        configurations: [configuration]
    )

    ContentView(context: ModelContext(container))
}
