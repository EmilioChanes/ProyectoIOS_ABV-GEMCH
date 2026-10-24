//
//  Componentes.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import SwiftUI

struct HeaderView: View {
    @Binding var path: [Destination]

    var showSearchBar: Bool = true
    var showHero: Bool = true

    @State private var searchText = ""

    private var query: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button {
                    path.removeAll()
                } label: {
                    Image(systemName: "house")
                        .font(.title)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                }
                .accessibilityLabel("Ir al inicio")

                Spacer()

                Button {
                    print("NavHamburguer")
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                }
                .accessibilityLabel("Menú")
            }

            if showHero {
                Text("MovieMap")
                    .font(.largeTitle)
                    .bold()

                Text("Descubre películas y guarda tus favoritas.")
                    .multilineTextAlignment(.center)
            }

            if showSearchBar {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField(
                        "Buscar una película...",
                        text: $searchText
                    )

                    NavigationLink(
                        value: Destination.results(query)
                    ) {
                        Text("Buscar")
                            .bold()
                            .padding(10)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    .disabled(query.isEmpty)
                }
                .padding()
                .background(.white)
                .cornerRadius(15)
            }
        }
        .padding()
        .foregroundStyle(.black)
        .background(Color.gray.opacity(0.2))
    }
}

struct FavoriteButtonView: View {
    @Environment(movieServices.self) private var service

    let movie: Movie

    var body: some View {
        Button {
            service.toggleFavorite(movie)
        } label: {
            Image(
                systemName: service.isFavorite(movie)
                    ? "heart.fill"
                    : "heart"
            )
            .font(.title2)
            .foregroundStyle(.red)
            .padding(8)
        }
        .accessibilityLabel(
            service.isFavorite(movie)
                ? "Quitar \(movie.title) de favoritos"
                : "Agregar \(movie.title) a favoritos"
        )
    }
}

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack(spacing: 8) {
            NavigationLink(
                value: Destination.detail(movie)
            ) {
                VStack(spacing: 8) {
                    Image(systemName: "film")
                        .font(.system(size: 50))
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)

                    Text(movie.title)
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Text(movie.year)
                        .font(.subheadline)
                }
                .foregroundStyle(.primary)
            }

            FavoriteButtonView(movie: movie)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}
