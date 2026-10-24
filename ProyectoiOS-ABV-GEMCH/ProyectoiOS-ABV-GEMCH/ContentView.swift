//
//  ContentView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var service = movieServices()
    @State private var path: [Destination] = []

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
                                    service.movies,
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

                        if service.favoriteMovies.isEmpty {
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
                                        service.favoriteMovies,
                                        id: \.id
                                    ) { movie in
                                        MovieCardView(
                                            movie: movie
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
                    SecondView(
                        destination: destination,
                        path: $path
                    )

                case .favorites:
                    SecondView(
                        destination: destination,
                        path: $path
                    )

                case .results:
                    SecondView(
                        destination: destination,
                        path: $path
                    )

                case .detail(let movie):
                    MovieDetailView(
                        movie: movie,
                        path: $path
                    )
                }
            }
        }
        .environment(service)
    }
}

#Preview {
    ContentView()
}
