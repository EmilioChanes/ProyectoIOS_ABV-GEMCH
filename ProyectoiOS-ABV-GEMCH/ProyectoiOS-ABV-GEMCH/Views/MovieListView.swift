//
//  SecondView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI

struct MovieListView: View {
    @Environment(\.verticalSizeClass)
    private var verticalSizeClass

    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    @State private var viewModel: MovieListViewModel
    @State private var searchText: String

    @Binding var path: [Destination]

    private var isCompactHeight: Bool {
        verticalSizeClass == .compact
    }

    private var columns: [GridItem] {
        Array(
            repeating: GridItem(
                .flexible(),
                spacing: isCompactHeight
                    ? MovieCardMetrics.compactColumnSpacing
                    : MovieCardMetrics.columnSpacing,
                alignment: .top
            ),
            count: isCompactHeight &&
                   !dynamicTypeSize.isAccessibilitySize
                ? 4
                : 2
        )
    }

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

        if case .results(let query) = destination {
            _searchText = State(
                initialValue: query
            )
        } else {
            _searchText = State(
                initialValue: ""
            )
        }
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                VStack(spacing: 12) {
                    HeaderView(
                        path: $path,
                        searchText: $searchText,
                        searchesFavorites: viewModel.isFavoritesScreen,
                        onFavoritesSearch: {
                            viewModel.applyFavoritesSearch(
                                searchText
                            )
                        }
                    )
                    .id("listTop")

                    VStack(
                        alignment: .leading,
                        spacing: isCompactHeight ? 16 : 24
                    ) {
                        HStack(spacing: 8) {
                            Text(viewModel.title)
                                .font(
                                    .system(
                                        isCompactHeight
                                            ? .title3
                                            : .title2,
                                        design: .monospaced,
                                        weight: .black
                                    )
                                )

                            if viewModel.isFavoritesScreen {
                                Image(
                                    systemName: "heart.fill"
                                )
                                .foregroundStyle(
                                    MovieMapStyle.accent
                                )
                                .accessibilityHidden(true)
                            }
                        }

                        if case .results = viewModel.destination,
                           !viewModel.isLoading,
                           viewModel.loadingErrorMessage == nil {
                            Text(
                                "\(viewModel.visibleMovies.count) películas en esta página"
                            )
                            .font(.subheadline)
                            .foregroundStyle(
                                MovieMapStyle.secondaryText
                            )
                        }

                        if viewModel.isFavoritesScreen {
                            favoritesContent
                        } else {
                            moviesContent
                        }
                    }
                    .padding(
                        isCompactHeight ? 16 : 24
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .border(
                        MovieMapStyle.divider,
                        width: 1
                    )
                }
                .padding(.bottom, 24)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .contentShape(Rectangle())
            .clipped()
            .onChange(
                of: viewModel.currentPage
            ) { _, page in
                if page != nil {
                    proxy.scrollTo(
                        "listTop",
                        anchor: .top
                    )
                }
            }
        }
        .foregroundStyle(.white)
        .background(
            MovieMapStyle.background
                .ignoresSafeArea()
        )
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .toolbar(
            .visible,
            for: .navigationBar
        )
        .toolbarBackground(
            MovieMapStyle.hero,
            for: .navigationBar
        )
        .toolbarBackground(
            .visible,
            for: .navigationBar
        )
        .tint(.white)
        .task {
            await viewModel.loadMovies()
        }
    }

    @ViewBuilder
    private var favoritesContent: some View {
        if viewModel.visibleFavorites.isEmpty {
            Text(viewModel.emptyMessage)
                .foregroundStyle(
                    MovieMapStyle.secondaryText
                )
                .frame(
                    maxWidth: .infinity,
                    minHeight: isCompactHeight ? 120 : 180
                )
                .multilineTextAlignment(.center)
        } else {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: isCompactHeight ? 16 : 24
            ) {
                ForEach(
                    viewModel.visibleFavorites,
                    id: \.id
                ) { favorite in
                    MovieFavoriteCardView(
                        favorite: favorite
                    )
                }
            }
        }
    }

    @ViewBuilder
    private var moviesContent: some View {
        if !viewModel.visibleMovies.isEmpty {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: isCompactHeight ? 16 : 24
            ) {
                ForEach(
                    viewModel.visibleMovies,
                    id: \.id
                ) { movie in
                    MovieCardView(
                        movie: movie
                    )
                }
            }
        } else if !viewModel.isLoading &&
                    viewModel.loadingErrorMessage == nil {
            Text(
                viewModel.isLatestScreen
                    ? "No hay películas que cumplan los filtros en esta página."
                    : viewModel.emptyMessage
            )
            .foregroundStyle(
                MovieMapStyle.secondaryText
            )
        }

        if viewModel.isLoading {
            ProgressView(
                "Cargando películas..."
            )
            .tint(.white)
            .frame(maxWidth: .infinity)
        } else if let message = viewModel.loadingErrorMessage {
            Text(message)
                .foregroundStyle(.pink)

            if viewModel.currentPage == nil {
                Button("Reintentar") {
                    Task {
                        await viewModel.loadMovies()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(MovieMapStyle.button)
            }
        }

        if viewModel.isLatestScreen,
           let page = viewModel.currentPage,
           viewModel.totalPages > 0 {
            pagination(page: page)
        }
    }

    private func pagination(
        page: Int
    ) -> some View {
        VStack(spacing: 12) {
            Text(
                "Página \(page) de \(viewModel.totalPages)"
            )
            .font(.subheadline)
            .foregroundStyle(
                MovieMapStyle.secondaryText
            )

            HStack {
                Button("Anterior") {
                    Task {
                        await viewModel.loadPage(
                            page - 1
                        )
                    }
                }
                .disabled(
                    page <= 1 ||
                    viewModel.isLoading
                )

                Spacer()

                Button("Siguiente") {
                    Task {
                        await viewModel.loadPage(
                            page + 1
                        )
                    }
                }
                .disabled(
                    page >= viewModel.totalPages ||
                    viewModel.isLoading
                )
            }
            .buttonStyle(.borderedProminent)
            .tint(MovieMapStyle.button)
        }
        .padding(.vertical, 8)
    }
}
