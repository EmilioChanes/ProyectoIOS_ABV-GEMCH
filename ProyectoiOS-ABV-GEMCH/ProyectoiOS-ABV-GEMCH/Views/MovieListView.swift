//
//  SecondView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI

struct MovieListView: View {
    @State private var viewModel: MovieListViewModel
    @State private var favoritesSearchText = ""
    @Binding var path: [Destination]

    private let columns = [
        GridItem(.flexible(), spacing: 12, alignment: .top),
        GridItem(.flexible(), spacing: 12, alignment: .top)
    ]

    init(
        destination: Destination,
        movieViewModel: MovieViewModel,
        path: Binding<[Destination]>
    ) {
        _viewModel = State(initialValue: MovieListViewModel(
            destination: destination,
            movieViewModel: movieViewModel
        ))
        _path = path
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    HeaderView(
                        path: $path,
                        showSearchBar: !viewModel.isFavoritesScreen
                    )
                    .id("listTop")

                    VStack(alignment: .leading, spacing: 16) {
                        Text(viewModel.title)
                            .font(.title2)
                            .bold()

                        if viewModel.isFavoritesScreen {
                            favoritesContent
                        } else {
                            moviesContent
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .onChange(of: viewModel.currentPage) { _, page in
                if page != nil {
                    proxy.scrollTo("listTop", anchor: .top)
                }
            }
        }
        .task {
            await viewModel.loadMovies()
        }
    }

    @ViewBuilder
    private var favoritesContent: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField(
                "Buscar en películas favoritas...",
                text: $favoritesSearchText
            )

            Button("Buscar") {
                viewModel.applyFavoritesSearch(favoritesSearchText)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)

        if viewModel.visibleFavorites.isEmpty {
            Text(viewModel.emptyMessage)
                .foregroundStyle(.secondary)
        } else {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.visibleFavorites, id: \.id) { favorite in
                    MovieFavoriteCardView(favorite: favorite)
                }
            }
        }
    }

    @ViewBuilder
    private var moviesContent: some View {
        if !viewModel.visibleMovies.isEmpty {
            if viewModel.isLatestScreen {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.visibleMovies, id: \.id) { movie in
                        MovieCardView(movie: movie)
                    }
                }
            } else {
                ForEach(viewModel.visibleMovies, id: \.id) { movie in
                    MovieCardView(movie: movie)
                }
            }
        } else if !viewModel.isLoading && viewModel.loadingErrorMessage == nil {
            Text(viewModel.emptyMessage)
                .foregroundStyle(.secondary)
        }

        if viewModel.isLoading {
            ProgressView("Cargando películas...")
                .frame(maxWidth: .infinity)
        } else if let message = viewModel.loadingErrorMessage {
            Text(message)
                .foregroundStyle(.red)

            if viewModel.currentPage == nil {
                Button("Reintentar") {
                    Task { await viewModel.loadMovies() }
                }
            }
        }

        if viewModel.isLatestScreen,
           let page = viewModel.currentPage,
           viewModel.totalPages > 0 {
            pagination(page: page)
        }
    }

    private func pagination(page: Int) -> some View {
        VStack(spacing: 12) {
            Text("Página \(page) de \(viewModel.totalPages)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Button("Anterior") {
                    Task { await viewModel.loadPage(page - 1) }
                }
                .disabled(page <= 1 || viewModel.isLoading)

                Spacer()

                Button("Siguiente") {
                    Task { await viewModel.loadPage(page + 1) }
                }
                .disabled(page >= viewModel.totalPages || viewModel.isLoading)
            }
            .buttonStyle(.bordered)
        }
        .padding(.vertical, 8)
    }
}
