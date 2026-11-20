//
//  DetallePeliculaView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    @Environment(MovieViewModel.self)
    private var movieViewModel

    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    @Environment(\.verticalSizeClass)
    private var verticalSizeClass

    @State private var viewModel: MovieDetailViewModel

    @Binding var path: [Destination]

    let movieID: Int
    let title: String
    let year: String
    let posterPath: String?

    private var isCompactHeight: Bool {
        verticalSizeClass == .compact
    }

    init(
        movieID: Int,
        title: String,
        year: String,
        posterPath: String? = nil,
        path: Binding<[Destination]>
    ) {
        self.movieID = movieID
        self.title = title
        self.year = year
        self.posterPath = posterPath

        _path = path

        _viewModel = State(
            initialValue: MovieDetailViewModel(
                movieID: movieID
            )
        )
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack(
                alignment: .leading,
                spacing: isCompactHeight ? 16 : 24
            ) {
                HStack {
                    HomeButtonView(
                        path: $path
                    )

                    Spacer()

                    if let movie = viewModel.movie {
                        FavoriteButtonView(
                            movie: movie,
                            isLarge: true
                        )
                    }
                }

                Text(
                    viewModel.movie?.title ?? title
                )
                .font(
                    isCompactHeight
                        ? .title
                        : .largeTitle
                )
                .bold()

                if let message = movieViewModel.errorMessage {
                    Text(message)
                        .foregroundStyle(.pink)
                }

                if viewModel.isLoading {
                    ProgressView(
                        "Cargando detalles..."
                    )
                    .tint(.white)
                } else if let message = viewModel.errorMessage {
                    Text(message)
                        .foregroundStyle(.pink)
                }

                if viewModel.movie != nil {
                    detailsContent
                } else {
                    poster
                        .frame(
                            maxWidth: isCompactHeight ? 140 : 240
                        )
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(
                isCompactHeight ? 16 : 24
            )
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .contentShape(Rectangle())
        .clipped()
        .foregroundStyle(.white)
        .background(
            MovieMapStyle.background
                .ignoresSafeArea()
        )
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .toolbar(
            .visible,
            for: .navigationBar
        )
        .toolbarBackground(
            MovieMapStyle.background,
            for: .navigationBar
        )
        .toolbarBackground(
            .visible,
            for: .navigationBar
        )
        .tint(.white)
        .task {
            await viewModel.loadMovie()
        }
    }

    private var detailsContent: some View {
        VStack(
            alignment: .leading,
            spacing: isCompactHeight ? 16 : 24
        ) {
            if dynamicTypeSize.isAccessibilitySize {
                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {
                    poster
                        .frame(maxWidth: 240)
                        .frame(maxWidth: .infinity)

                    metadata
                }
            } else {
                HStack(
                    alignment: .top,
                    spacing: 18
                ) {
                    poster
                        .frame(
                            minWidth: 0,
                            maxWidth: isCompactHeight
                                ? 140
                                : .infinity
                        )

                    metadata
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                }
            }

            HStack(
                alignment: .top,
                spacing: 12
            ) {
                Text("Dirección")
                    .bold()
                    .foregroundStyle(
                        MovieMapStyle.accent
                    )

                Text(
                    availableText(
                        viewModel.movie?.director
                    ) ?? "Sin dirección disponible"
                )
            }
            .font(.subheadline)

            Text("Sinopsis")
                .font(.title)
                .bold()

            Text(
                availableText(
                    viewModel.movie?.synopsis
                ) ?? "Sin sinopsis disponible"
            )
            .font(.body)
            .lineSpacing(4)

            Rectangle()
                .fill(
                    MovieMapStyle.divider
                )
                .frame(height: 1)

            Text("Reparto principal")
                .font(.title)
                .bold()

            castContent
        }
    }

    private var poster: some View {
        MoviePosterView(
            movieID: movieID,
            posterPath: viewModel.movie?.posterPath
                ?? posterPath
        )
    }

    private var metadata: some View {
        VStack(
            alignment: .leading,
            spacing: isCompactHeight ? 12 : 18
        ) {
            informationField(
                "ESTRENO",
                value: releaseDateText
            )

            informationField(
                "CLASIFICACIÓN",
                value: availableText(
                    viewModel.movie?.classification
                ) ?? "Sin clasificación disponible"
            )

            informationField(
                "GÉNEROS",
                value: availableText(
                    viewModel.movie?.category
                ) ?? "Sin categoría disponible"
            )

            informationField(
                "DURACIÓN",
                value: runtimeText
            )

            VStack(
                alignment: .leading,
                spacing: 6
            ) {
                fieldTitle("CALIFICACIÓN")

                ratingContent
            }
        }
    }

    private func informationField(
        _ label: String,
        value: String
    ) -> some View {
        VStack(
            alignment: .leading,
            spacing: 6
        ) {
            fieldTitle(label)

            Text(value)
                .font(.subheadline)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
        }
    }

    private func fieldTitle(
        _ label: String
    ) -> some View {
        Text(label)
            .font(.caption)
            .bold()
            .foregroundStyle(
                MovieMapStyle.accent
            )
    }

    @ViewBuilder
    private var ratingContent: some View {
        if let rating = viewModel.movie?.rating,
           rating > 0 {
            let score = min(
                max(rating / 2, 0),
                5
            )

            HStack(spacing: 6) {
                HStack(spacing: 2) {
                    ForEach(
                        1...5,
                        id: \.self
                    ) { position in
                        Image(
                            systemName: starName(
                                position: position,
                                score: score
                            )
                        )
                    }
                }
                .font(.caption)
                .foregroundStyle(
                    MovieMapStyle.accent
                )
                .accessibilityHidden(true)

                Text(
                    "\(score, specifier: "%.1f") / 5"
                )
                .font(.caption)
                .bold()
            }
            .accessibilityElement(
                children: .ignore
            )
            .accessibilityLabel(
                Text(
                    "Calificación: \(score, specifier: "%.1f") de 5"
                )
            )
        } else {
            Text(
                "Sin calificación disponible"
            )
            .font(.subheadline)
        }
    }

    private func starName(
        position: Int,
        score: Double
    ) -> String {
        if score >= Double(position) {
            return "star.fill"
        }

        if score >= Double(position) - 0.5 {
            return "star.leadinghalf.filled"
        }

        return "star"
    }

    @ViewBuilder
    private var castContent: some View {
        let names = (
            viewModel.movie?.cast ?? []
        )
        .compactMap {
            availableText($0)
        }

        if names.isEmpty {
            Text("Sin reparto disponible")
                .foregroundStyle(
                    MovieMapStyle.secondaryText
                )
        } else {
            ScrollView(.horizontal) {
                HStack(
                    alignment: .top,
                    spacing: 16
                ) {
                    ForEach(
                        names.indices,
                        id: \.self
                    ) { index in
                        VStack(spacing: 10) {
                            Image(
                                systemName: "person.fill"
                            )
                            .font(
                                .system(size: 65)
                            )
                            .foregroundStyle(
                                MovieMapStyle.accent
                            )
                            .frame(
                                width: 110,
                                height: 130
                            )
                            .background(
                                MovieMapStyle.surface
                            )
                            .cornerRadius(12)
                            .accessibilityHidden(true)

                            Text(names[index])
                                .font(.subheadline)
                                .bold()
                                .multilineTextAlignment(.center)
                                .lineLimit(
                                    2,
                                    reservesSpace: true
                                )
                        }
                        .frame(width: 110)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
    }

    private var releaseDateText: String {
        let fallback = availableText(
            viewModel.movie?.year ?? year
        ) ?? "Sin fecha de estreno disponible"

        guard let value = availableText(
            viewModel.movie?.releaseDate
        ) else {
            return fallback
        }

        let formatter = DateFormatter()

        formatter.locale = Locale(
            identifier: "en_US_POSIX"
        )

        formatter.calendar = Calendar(
            identifier: .gregorian
        )

        formatter.dateFormat = "yyyy-MM-dd"

        guard let date = formatter.date(
            from: value
        ) else {
            return fallback
        }

        formatter.locale = Locale(
            identifier: "es_MX"
        )

        formatter.dateFormat = "d 'de' MMMM 'de' yyyy"

        return formatter.string(from: date)
    }

    private var runtimeText: String {
        guard let minutes = viewModel.movie?.runtime,
              minutes > 0 else {
            return "Sin duración disponible"
        }

        let hours = minutes / 60
        let remainingMinutes = minutes % 60

        if hours > 0 {
            return "\(hours) h \(remainingMinutes) min"
        }

        return "\(remainingMinutes) min"
    }

    private func availableText(
        _ value: String?
    ) -> String? {
        guard let value else {
            return nil
        }

        let text = value.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        switch text.lowercased() {
        case "",
             "no disponible",
             "sinopsis no disponible",
             "sinopsis no disponible.":
            return nil

        default:
            return text
        }
    }
}
