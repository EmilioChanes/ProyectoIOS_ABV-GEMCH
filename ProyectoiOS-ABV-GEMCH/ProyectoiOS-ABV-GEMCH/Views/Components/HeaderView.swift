//
//  HeaderView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    @Environment(MovieViewModel.self)
    private var movieViewModel

    @Environment(\.verticalSizeClass)
    private var verticalSizeClass

    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    @Binding var path: [Destination]
    @Binding var searchText: String

    var showHomeButton = true
    var searchesFavorites = false
    var onFavoritesSearch: () -> Void = {}

    @ScaledMetric(relativeTo: .largeTitle)
    private var brandSize: CGFloat = 52

    @ScaledMetric(relativeTo: .title)
    private var compactBrandSize: CGFloat = 30

    init(
        path: Binding<[Destination]>,
        searchText: Binding<String>,
        showHomeButton: Bool = true,
        searchesFavorites: Bool = false,
        onFavoritesSearch: @escaping () -> Void = {}
    ) {
        _path = path
        _searchText = searchText

        self.showHomeButton = showHomeButton
        self.searchesFavorites = searchesFavorites
        self.onFavoritesSearch = onFavoritesSearch
    }

    private var useCompactLayout: Bool {
        verticalSizeClass == .compact &&
        !dynamicTypeSize.isAccessibilitySize
    }

    private var query: String {
        searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }

    var body: some View {
        VStack(
            spacing: useCompactLayout ? 8 : 16
        ) {
            if useCompactLayout {
                HStack(spacing: 16) {
                    if showHomeButton {
                        HomeButtonView(
                            path: $path,
                            isCircular: true
                        )
                    }

                    brand

                    descriptionText
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                }
            } else {
                brand

                descriptionText
            }

            searchBar

            if let message = movieViewModel.errorMessage {
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(
            .horizontal,
            useCompactLayout ? 16 : 24
        )
        .padding(
            .top,
            useCompactLayout
                ? 12
                : (showHomeButton ? 60 : 36)
        )
        .padding(
            .bottom,
            useCompactLayout ? 12 : 26
        )
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
        .background(MovieMapStyle.hero)
        .overlay(alignment: .topLeading) {
            if showHomeButton && !useCompactLayout {
                HomeButtonView(
                    path: $path,
                    isCircular: true
                )
                .padding(8)
            }
        }
    }

    private var brand: some View {
        Text("MovieMap")
            .font(
                .system(
                    size: useCompactLayout
                        ? compactBrandSize
                        : brandSize,
                    weight: .black,
                    design: .monospaced
                )
            )
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity)
    }

    private var descriptionText: some View {
        Text(
            "Explora películas, descubre sus historias y guarda tus favoritas en un solo lugar."
        )
        .font(
            useCompactLayout
                ? .caption
                : .subheadline
        )
        .multilineTextAlignment(
            useCompactLayout
                ? .leading
                : .center
        )
        .fixedSize(
            horizontal: false,
            vertical: true
        )
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(
                systemName: "magnifyingglass"
            )
            .font(.title3)
            .accessibilityHidden(true)

            TextField(
                "",
                text: $searchText,
                prompt: Text(
                    searchesFavorites
                        ? "Buscar en películas favoritas..."
                        : "Buscar una película..."
                )
                .foregroundStyle(
                    MovieMapStyle.secondaryText
                )
            )
            .font(.subheadline)
            .accessibilityLabel(
                searchesFavorites
                    ? "Buscar en películas favoritas"
                    : "Buscar una película"
            )

            if searchesFavorites {
                Button(action: onFavoritesSearch) {
                    searchLabel
                }
                .buttonStyle(.plain)
            } else {
                NavigationLink(
                    value: Destination.results(query)
                ) {
                    searchLabel
                }
                .buttonStyle(.plain)
                .disabled(query.isEmpty)
                .opacity(
                    query.isEmpty ? 0.65 : 1
                )
            }
        }
        .padding(6)
        .padding(.leading, 6)
        .background(
            MovieMapStyle.surface
        )
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(
                cornerRadius: 12
            )
            .stroke(
                MovieMapStyle.button,
                lineWidth: 2
            )
            .allowsHitTesting(false)
        }
    }

    private var searchLabel: some View {
        Text("Buscar")
            .font(
                .system(
                    .subheadline,
                    design: .monospaced,
                    weight: .bold
                )
            )
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .frame(minHeight: 44)
            .background(
                MovieMapStyle.button
            )
            .cornerRadius(8)
    }
}

struct HomeButtonView: View {
    @Binding var path: [Destination]

    var isCircular = false

    var body: some View {
        Button {
            path.removeAll()
        } label: {
            Image(systemName: "house")
                .font(
                    .system(
                        size: 25,
                        weight: .light
                    )
                )
                .foregroundStyle(.white)
                .frame(
                    width: 44,
                    height: 44
                )
                .background(
                    MovieMapStyle.surface
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: isCircular ? 22 : 12
                    )
                )
                .overlay {
                    RoundedRectangle(
                        cornerRadius: isCircular ? 22 : 12
                    )
                    .stroke(
                        isCircular
                            ? MovieMapStyle.button
                            : MovieMapStyle.surface,
                        lineWidth: 1
                    )
                }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Ir al inicio")
    }
}
