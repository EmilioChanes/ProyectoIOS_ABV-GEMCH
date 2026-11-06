//
//  FavoriteButtonView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//
import SwiftUI

struct FavoriteButtonView: View {
    @Environment(MovieViewModel.self) private var movieViewModel

    let movie: Movie

    var body: some View {
        Button {
            movieViewModel.toggleFavorite(movie)
        } label: {
            Image(
                systemName: movieViewModel.isFavorite(movie)
                    ? "heart.fill"
                    : "heart"
            )
            .font(.title2)
            .foregroundStyle(.red)
            .padding(8)
        }
        .accessibilityLabel(
            movieViewModel.isFavorite(movie)
                ? "Quitar \(movie.title) de favoritos"
                : "Agregar \(movie.title) a favoritos"
        )
    }
}
