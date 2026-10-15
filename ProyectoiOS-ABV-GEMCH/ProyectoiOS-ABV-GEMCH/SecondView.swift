//
//  SecondView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI

struct SecondView: View {
    @Environment(movieServices.self) private var service

    let destination: Destination

    @Binding var path: [Destination]

    @State private var favoritesSearchText = ""
    @State private var favoritesQuery = ""

    private var isFavoritesScreen: Bool {
        if case .favorites = destination {
            return true
        }

        return false
    }

    private var title: String {
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

    private var visibleMovies: [Movie] {
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

    private var emptyMessage: String {
        if isFavoritesScreen &&
            service.favoriteMovies.isEmpty {
            return "Aún no tienes películas favoritas guardadas."
        }

        return "No se encontraron películas que coincidan."
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(
                    path: $path,
                    showSearchBar: !isFavoritesScreen
                )

                VStack(alignment: .leading, spacing: 16) {
                    Text(title)
                        .font(.title2)
                        .bold()

                    if isFavoritesScreen {
                        HStack {
                            Image(systemName: "magnifyingglass")

                            TextField(
                                "Buscar en películas favoritas...",
                                text: $favoritesSearchText
                            )

                            Button("Buscar") {
                                favoritesQuery = favoritesSearchText
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }

                    if visibleMovies.isEmpty {
                        Text(emptyMessage)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(
                            visibleMovies,
                            id: \.id
                        ) { movie in
                            MovieCardView(
                                movie: movie
                            )
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(title)
    }
}
