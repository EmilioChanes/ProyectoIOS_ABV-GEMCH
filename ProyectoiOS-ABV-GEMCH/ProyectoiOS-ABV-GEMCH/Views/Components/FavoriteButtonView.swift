//
//  FavoriteButtonView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//
import SwiftUI

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
