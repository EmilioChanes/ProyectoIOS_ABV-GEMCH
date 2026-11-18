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
        MovieCardLayout(
            movieID: favorite.id,
            title: favorite.title,
            year: favorite.year,
            posterPath: favorite.posterPath,
            destination: .favoriteDetail(favorite),
            favoriteControl: removeButton
        )
    }

    private var removeButton: some View {
        Button {
            movieViewModel.removeFavorite(id: favorite.id)
        } label: {
            Image(systemName: "heart.fill")
                .font(.title2)
                .foregroundStyle(.red)
                .padding(8)
        }
        .accessibilityLabel("Quitar \(favorite.title) de favoritos")
    }
}