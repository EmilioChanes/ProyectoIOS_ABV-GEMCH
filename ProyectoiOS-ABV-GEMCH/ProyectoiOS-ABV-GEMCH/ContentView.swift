//
//  ContentView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.verticalSizeClass)
    private var verticalSizeClass

    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    @State private var movieViewModel: MovieViewModel
    @State private var path: [Destination] = []
    @State private var searchText = ""

    init(context: ModelContext) {
        let service = MovieService(
            context: context
        )

        _movieViewModel = State(
            initialValue: MovieViewModel(
                service: service
            )
        )
    }

    private var isCompactHeight: Bool {
        verticalSizeClass == .compact
    }

    private var sidePadding: CGFloat {
        isCompactHeight ? 16 : 24
    }

    private var cardWidth: CGFloat {
        MovieCardMetrics.carouselWidth(
            isCompactHeight: isCompactHeight,
            isAccessibilitySize: dynamicTypeSize.isAccessibilitySize
        )
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical) {
                VStack(
                    spacing: isCompactHeight ? 16 : 24
                ) {
                    HeaderView(
                        path: $path,
                        searchText: $searchText,
                        showHomeButton: false
                    )

                    latestSection

                    favoritesSection
                }
                .padding(.bottom, 24)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .contentShape(Rectangle())
            .clipped()
            .background(
                MovieMapStyle.background
                    .ignoresSafeArea()
            )
            .toolbar(
                .hidden,
                for: .navigationBar
            )
            .navigationDestination(
                for: Destination.self
            ) { destination in
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
        .preferredColorScheme(.dark)
        .tint(.white)
        .task {
            await movieViewModel.loadLatestMovies()
        }
    }

    private var latestSection: some View {
        VStack(
            alignment: .leading,
            spacing: isCompactHeight ? 12 : 20
        ) {
            sectionHeader(
                "Últimas películas",
                destination: .latest
            )
            .padding(
                .horizontal,
                sidePadding
            )

            if movieViewModel.isLoadingMovies {
                ProgressView(
                    "Cargando películas..."
                )
                .frame(maxWidth: .infinity)
            } else if let message = movieViewModel.moviesErrorMessage {
                Text(message)
                    .foregroundStyle(.pink)
                    .padding(
                        .horizontal,
                        sidePadding
                    )
            } else if movieViewModel.movies.isEmpty {
                Text(
                    "No hay películas recientes que cumplan los filtros en esta página."
                )
                .padding(
                    .horizontal,
                    sidePadding
                )
            } else {
                MovieCarousel {
                    ForEach(
                        movieViewModel.movies.prefix(20),
                        id: \.id
                    ) { movie in
                        MovieCardView(
                            movie: movie
                        )
                        .frame(
                            width: cardWidth
                        )
                    }
                }
            }
        }
        .padding(
            .vertical,
            isCompactHeight ? 16 : 24
        )
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .foregroundStyle(.white)
        .border(
            MovieMapStyle.divider,
            width: 1
        )
    }

    private var favoritesSection: some View {
        VStack(
            alignment: .leading,
            spacing: isCompactHeight ? 12 : 20
        ) {
            sectionHeader(
                "Películas favoritas",
                destination: .favorites,
                showsHeart: true
            )
            .padding(
                .horizontal,
                sidePadding
            )

            if movieViewModel.favoriteMovies.isEmpty {
                Text(
                    "Aún no tienes películas favoritas guardadas..."
                )
                .font(
                    .system(
                        .title3,
                        design: .monospaced,
                        weight: .bold
                    )
                )
                .multilineTextAlignment(.center)
                .frame(
                    maxWidth: .infinity,
                    minHeight: isCompactHeight ? 120 : 220
                )
                .padding(
                    .horizontal,
                    sidePadding
                )
            } else {
                MovieCarousel {
                    ForEach(
                        movieViewModel.favoriteMovies.prefix(20),
                        id: \.id
                    ) { favorite in
                        MovieFavoriteCardView(
                            favorite: favorite
                        )
                        .frame(
                            width: cardWidth
                        )
                    }
                }
            }
        }
        .padding(
            .vertical,
            isCompactHeight ? 16 : 24
        )
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .foregroundStyle(.white)
        .border(
            MovieMapStyle.divider,
            width: 1
        )
    }

    private func sectionHeader(
        _ title: String,
        destination: Destination,
        showsHeart: Bool = false
    ) -> some View {
        HStack(spacing: 8) {
            Text(title)
                .font(
                    .system(
                        isCompactHeight ? .title3 : .title2,
                        design: .monospaced,
                        weight: .black
                    )
                )
                .layoutPriority(1)

            if showsHeart {
                Image(
                    systemName: "heart.fill"
                )
                .foregroundStyle(
                    MovieMapStyle.accent
                )
                .accessibilityHidden(true)
            }

            Spacer(minLength: 0)

            NavigationLink(value: destination) {
                Text("Ver más")
                    .font(
                        .system(
                            .caption,
                            design: .monospaced,
                            weight: .bold
                        )
                    )
                    .padding(.horizontal, 8)
                    .frame(minHeight: 44)
                    .background(
                        MovieMapStyle.button
                    )
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(
                "Ver más: \(title)"
            )
        }
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

    ContentView(
        context: ModelContext(container)
    )
}
