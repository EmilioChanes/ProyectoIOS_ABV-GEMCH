//
//  DetallePeliculaView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    @State private var viewModel: MovieDetailViewModel
    @Binding var path: [Destination]

    let movieID: Int
    let title: String
    let year: String
    let posterPath: String?

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
        _viewModel = State(initialValue: MovieDetailViewModel(movieID: movieID))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(path: $path, showSearchBar: false, showHero: false)

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(viewModel.movie?.title ?? title)
                            .font(.largeTitle)
                            .bold()

                        Spacer()

                        if let movie = viewModel.movie {
                            FavoriteButtonView(movie: movie)
                        }
                    }

                    MoviePosterView(
                        movieID: movieID,
                        posterPath: viewModel.movie?.posterPath ?? posterPath
                    )
                    .frame(maxWidth: 250)
                    .frame(maxWidth: .infinity)

                    let releaseYear = viewModel.movie?.year ?? year
                    Text("Año de estreno: \(availableText(releaseYear) ?? "Sin año de estreno disponible")")

                    if viewModel.isLoading {
                        Text("Cargando detalles...")
                            .foregroundStyle(.secondary)
                    } else if let message = viewModel.errorMessage {
                        Text(message)
                            .foregroundStyle(.red)
                    } else if let movie = viewModel.movie {
                        Text("Clasificación: \(availableText(movie.classification) ?? "Sin clasificación disponible")")
                        Text("Categoría: \(availableText(movie.category) ?? "Sin categoría disponible")")
                        Text("Director: \(availableText(movie.director) ?? "Sin información de dirección disponible")")

                        if let rating = movie.rating, rating > 0 {
                            Text("Calificación: \(rating, specifier: "%.1f") / 10")
                        } else {
                            Text("Calificación: Sin calificación disponible")
                        }

                        Text("Sinopsis")
                            .font(.title2)
                            .bold()

                        Text(availableText(movie.synopsis) ?? "Sin sinopsis disponible")

                        Text("Reparto principal")
                            .font(.title2)
                            .bold()

                        let cast = movie.cast.compactMap { availableText($0) }

                        if cast.isEmpty {
                            Text("Sin reparto disponible")
                                .foregroundStyle(.secondary)
                        } else {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top, spacing: 16) {
                                    ForEach(cast.indices, id: \.self) { index in
                                        VStack(spacing: 8) {
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 40))
                                                .frame(width: 100, height: 100)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(12)

                                            Text(cast[index])
                                                .multilineTextAlignment(.center)
                                        }
                                        .frame(width: 120)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .task {
            await viewModel.loadMovie()
        }
    }

    private func availableText(_ value: String?) -> String? {
        guard let value else {
            return nil
        }

        let text = value.trimmingCharacters(in: .whitespacesAndNewlines)

        switch text.lowercased() {
        case "", "no disponible", "sinopsis no disponible", "sinopsis no disponible.":
            return nil
        default:
            return text
        }
    }
}
