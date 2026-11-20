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

    var isLarge = false

    var body: some View {
        Button {
            movieViewModel.toggleFavorite(movie)
        } label: {
            FavoriteIconView(
                isFavorite: movieViewModel.isFavorite(movie),
                isLarge: isLarge
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(
            movieViewModel.isFavorite(movie)
                ? "Quitar \(movie.title) de favoritos"
                : "Agregar \(movie.title) a favoritos"
        )
    }
}

struct FavoriteIconView: View {
    let isFavorite: Bool

    var isLarge = false

    var body: some View {
        Image(
            systemName: isFavorite
                ? "heart.fill"
                : "heart"
        )
        .font(
            .system(
                size: isLarge ? 27 : 22
            )
        )
        .foregroundStyle(
            isFavorite
                ? MovieMapStyle.accent
                : .white
        )
        .frame(
            width: isLarge ? 48 : 44,
            height: isLarge ? 48 : 44
        )
        .background(
            isLarge
                ? MovieMapStyle.surface
                : MovieMapStyle.background
        )
        .cornerRadius(12)
        .accessibilityHidden(true)
    }
}
