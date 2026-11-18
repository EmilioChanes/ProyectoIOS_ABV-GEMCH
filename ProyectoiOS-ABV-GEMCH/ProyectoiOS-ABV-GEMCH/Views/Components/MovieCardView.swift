//
//  MovieCardView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        MovieCardLayout(
            movieID: movie.id,
            title: movie.title,
            year: movie.year,
            posterPath: movie.posterPath,
            destination: .detail(movie),
            favoriteControl: FavoriteButtonView(movie: movie)
        )
    }
}
