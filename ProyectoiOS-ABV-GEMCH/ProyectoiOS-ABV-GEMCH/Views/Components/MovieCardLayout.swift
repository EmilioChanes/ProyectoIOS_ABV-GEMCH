//
//  MovieCardLayout.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//

import SwiftUI

enum MovieCardMetrics {
    static let columnSpacing: CGFloat = 20
    static let compactColumnSpacing: CGFloat = 16

    static let titleHeight: CGFloat = 40
    static let yearHeight: CGFloat = 18

    static let cardSpacing: CGFloat = 8
    static let labelSpacing: CGFloat = 4

    static func carouselWidth(
        isCompactHeight: Bool,
        isAccessibilitySize: Bool
    ) -> CGFloat {
        isCompactHeight && !isAccessibilitySize ? 110 : 146
    }
}

struct MovieCardLayout<FavoriteControl: View>: View {
    let movieID: Int
    let title: String
    let year: String
    let posterPath: String?
    let destination: Destination
    let favoriteControl: FavoriteControl

    @ScaledMetric(relativeTo: .subheadline)
    private var titleHeight: CGFloat = MovieCardMetrics.titleHeight

    @ScaledMetric(relativeTo: .caption)
    private var yearHeight: CGFloat = MovieCardMetrics.yearHeight

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
        VStack(spacing: MovieCardMetrics.cardSpacing) {
            ZStack(alignment: .topTrailing) {
                NavigationLink(value: destination) {
                    MoviePosterView(
                        movieID: movieID,
                        posterPath: posterPath
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(
                    "Ver detalles de \(title)"
                )

                favoriteControl
                    .padding(2)
            }

            NavigationLink(value: destination) {
                VStack(
                    spacing: MovieCardMetrics.labelSpacing
                ) {
                    Text(title)
                        .font(.subheadline)
                        .bold()
                        .lineLimit(2, reservesSpace: true)
                        .multilineTextAlignment(.center)
                        .frame(
                            height: titleHeight,
                            alignment: .top
                        )
                        .frame(maxWidth: .infinity)

                    Text(
                        year.isEmpty
                            ? "Sin año disponible"
                            : year
                    )
                    .font(.caption)
                    .lineLimit(1, reservesSpace: true)
                    .frame(height: yearHeight)
                }
                .foregroundStyle(.white)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity
                )
            }
            .buttonStyle(.plain)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
    }
}

struct MovieCarousel<Content: View>: View {
    @Environment(\.verticalSizeClass)
    private var verticalSizeClass

    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    @ScaledMetric(relativeTo: .subheadline)
    private var titleHeight: CGFloat = MovieCardMetrics.titleHeight

    @ScaledMetric(relativeTo: .caption)
    private var yearHeight: CGFloat = MovieCardMetrics.yearHeight

    private let content: Content

    init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }

    private var isCompactHeight: Bool {
        verticalSizeClass == .compact
    }

    private var cardWidth: CGFloat {
        MovieCardMetrics.carouselWidth(
            isCompactHeight: isCompactHeight,
            isAccessibilitySize: dynamicTypeSize.isAccessibilitySize
        )
    }

    private var contentHeight: CGFloat {
        cardWidth * 1.5
            + titleHeight
            + yearHeight
            + MovieCardMetrics.cardSpacing
            + MovieCardMetrics.labelSpacing
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack(
                alignment: .top,
                spacing: isCompactHeight
                    ? MovieCardMetrics.compactColumnSpacing
                    : MovieCardMetrics.columnSpacing
            ) {
                content
            }
            .padding(
                .horizontal,
                isCompactHeight ? 16 : 24
            )
        }
        .frame(maxWidth: .infinity)
        .frame(height: contentHeight)
        .contentShape(Rectangle())
        .clipped()
        .scrollIndicators(.hidden)
    }
}
