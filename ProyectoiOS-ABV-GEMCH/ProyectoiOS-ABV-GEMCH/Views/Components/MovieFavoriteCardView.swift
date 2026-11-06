//
//  MovieFavoriteCardView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 05/11/26.
//

import SwiftUI

struct MovieFavoriteCardView: View {
    @Environment(MovieViewModel.self) private var movieViewModel

    let favorite: MovieFavorite

    var body: some View {
        VStack(spacing: 8) {
            NavigationLink(
                value: Destination.favoriteDetail(favorite)
            ) {
                VStack(spacing: 8) {
                    Image(systemName: "film")
                        .font(.system(size: 50))
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)

                    Text(favorite.title)
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Text(favorite.year)
                        .font(.subheadline)
                }
                .foregroundStyle(.primary)
            }

            Button {
                movieViewModel.removeFavorite(id: favorite.id)
            } label: {
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundStyle(.red)
                    .padding(8)
            }
            .accessibilityLabel(
                "Quitar \(favorite.title) de favoritos"
            )
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}
