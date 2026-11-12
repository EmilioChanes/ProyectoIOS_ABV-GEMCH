//
//  SecondView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI

struct MovieListView: View {
    @State private var viewModel: MovieListViewModel

    @Binding var path: [Destination]

    @State private var favoritesSearchText = ""

    init(
        destination: Destination,
        movieViewModel: MovieViewModel,
        path: Binding<[Destination]>
    ) {
        _viewModel = State(
            initialValue: MovieListViewModel(
                destination: destination,
                movieViewModel: movieViewModel
            )
        )

        _path = path
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(
                    path: $path,
                    showSearchBar: !viewModel.isFavoritesScreen
                )

                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.title)
                        .font(.title2)
                        .bold()

                    if viewModel.isFavoritesScreen {
                        HStack {
                            Image(systemName: "magnifyingglass")

                            TextField(
                                "Buscar en películas favoritas...",
                                text: $favoritesSearchText
                            )

                            Button("Buscar") {
                                viewModel.applyFavoritesSearch(
                                    favoritesSearchText
                                )
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)

                        if viewModel.visibleFavorites.isEmpty {
                            Text(viewModel.emptyMessage)
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(
                                viewModel.visibleFavorites,
                                id: \.id
                            ) { favorite in
                                MovieFavoriteCardView(
                                    favorite: favorite
                                )
                            }
                        }
                    } else {
                        if viewModel.isLoading {
                            Text("Cargando películas...")
                                .foregroundStyle(.secondary)
                        } else if let errorMessage =
                            viewModel.loadingErrorMessage {
                            Text(errorMessage)
                                .foregroundStyle(.red)
                        } else if viewModel.visibleMovies.isEmpty {
                            Text(viewModel.emptyMessage)
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(
                                viewModel.visibleMovies,
                                id: \.id
                            ) { movie in
                                MovieCardView(movie: movie)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .task {
            await viewModel.loadMovies()
        }
    }
}