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
        VStack(spacing: 8) {
            NavigationLink(value: Destination.detail(movie)) {
                VStack(spacing: 8) {
                    MoviePosterView(movieID: movie.id, posterPath: movie.posterPath)
                        .frame(maxWidth: 200)

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
