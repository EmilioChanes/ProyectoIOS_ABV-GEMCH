//
//  MovieCardLayout.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//

import SwiftUI

enum MovieCardMetrics {
    static let maxWidth: CGFloat = 180
    static let columnSpacing: CGFloat = 12
}

struct MovieCardLayout<FavoriteControl: View>: View {
    let movieID: Int
    let title: String
    let year: String
    let posterPath: String?
    let destination: Destination
    let favoriteControl: FavoriteControl

    @ScaledMetric(relativeTo: .title2)
    private var favoriteControlHeight: CGFloat = 48

    init(
        movieID: Int,
        title: String,
        year: String,
        posterPath: String?,
        destination: Destination,
        favoriteControl: FavoriteControl
    ) {
        self.movieID = movieID
        self.title = title
        self.year = year
        self.posterPath = posterPath
        self.destination = destination
        self.favoriteControl = favoriteControl
    }

    var body: some View {
        VStack(spacing: 8) {
            NavigationLink(value: destination) {
                VStack(spacing: 8) {
                    MoviePosterView(movieID: movieID, posterPath: posterPath)

                    Text(title)
                        .font(.headline)
                        .lineLimit(2, reservesSpace: true)
                        .multilineTextAlignment(.center)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity)

                    Text(year.isEmpty ? "Sin año disponible" : year)
                        .font(.subheadline)
                        .lineLimit(1, reservesSpace: true)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundStyle(.primary)
            }
            .buttonStyle(.plain)

            favoriteControl
                .frame(height: favoriteControlHeight)
        }
        .padding(12)
        .frame(minWidth: 0, maxWidth: MovieCardMetrics.maxWidth)
        .background(
            Color.gray.opacity(0.1),
            in: RoundedRectangle(cornerRadius: 15)
        )
    }
}