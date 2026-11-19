//
//  MoviePosterView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 12/11/26.
//

import Foundation
import SwiftUI

struct MoviePosterView: View {
    let movieID: Int
    let posterPath: String?

    var body: some View {
        Color.gray.opacity(0.15)
            .aspectRatio(2.0 / 3.0, contentMode: .fit)
            .overlay {
                MoviePosterContent(movieID: movieID, posterPath: posterPath)
                    .id(PosterKey(movieID: movieID, path: posterPath))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private struct PosterKey: Hashable {
        let movieID: Int
        let path: String?
    }
}

private struct MoviePosterContent: View {
    @Environment(MovieViewModel.self) private var movieViewModel
    @State private var alternativePath: String?
    @State private var didFinishLookup = false

    let movieID: Int
    let posterPath: String?

    var body: some View {
        if let url = imageURL(for: alternativePath ?? posterPath) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    loadingPoster

                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .accessibilityHidden(true)
                        .task(id: alternativePath) {
                            if let alternativePath, !Task.isCancelled {
                                movieViewModel.saveRecoveredPoster(
                                    movieID: movieID,
                                    posterPath: alternativePath
                                )
                            }
                        }

                case .failure(let error):
                    posterStatus.task(id: url) {
                        print("Portada | ID \(movieID) | Falló la descarga:", url, error)
                        await findAlternative(excluding: posterPath)
                    }

                @unknown default:
                    unavailablePoster
                }
            }
            .id(url)
        } else {
            posterStatus.task {
                guard !didFinishLookup else { return }

                print("Portada | ID \(movieID) | Sin ruta de portada válida")
                await findAlternative(excluding: nil)
            }
        }
    }

    private func imageURL(for path: String?) -> URL? {
        guard let path, path.hasPrefix("/"), path.count > 1 else {
            return nil
        }

        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    private func findAlternative(excluding path: String?) async {
        guard !didFinishLookup, !Task.isCancelled else {
            return
        }

        let result = await movieViewModel.findAlternativePoster(
            movieID: movieID,
            excluding: path
        )

        guard !Task.isCancelled else {
            return
        }

        didFinishLookup = true
        alternativePath = result
    }

    @ViewBuilder
    private var posterStatus: some View {
        if didFinishLookup {
            unavailablePoster
        } else {
            loadingPoster
        }
    }

    private var loadingPoster: some View {
        ProgressView()
            .accessibilityLabel("Cargando portada")
    }

    private var unavailablePoster: some View {
        VStack(spacing: 8) {
            Image(systemName: "film")
                .font(.largeTitle)
                .accessibilityHidden(true)

            Text("Sin portada disponible")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.secondary)
        .padding(8)
    }
}
