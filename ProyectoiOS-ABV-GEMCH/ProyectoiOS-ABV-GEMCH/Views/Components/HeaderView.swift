//
//  HeaderView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//

import SwiftUI

struct HeaderView: View {
    @Environment(MovieViewModel.self) private var movieViewModel

    @Binding var path: [Destination]

    var showSearchBar: Bool = true
    var showHero: Bool = true
    var showHomeButton: Bool = true

    @State private var searchText = ""

    private var query: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        VStack(spacing: 12) {
            if showHomeButton {
                HStack {
                    Button {
                        path.removeAll()
                    } label: {
                        Image(systemName: "house")
                            .font(.title)
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                    }
                    .accessibilityLabel("Ir al inicio")

                    Spacer()
                }
            }

            if showHero {
                Text("MovieMap")
                    .font(.largeTitle)
                    .bold()

                Text("Descubre películas y guarda tus favoritas.")
                    .multilineTextAlignment(.center)
            }

            if showSearchBar {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField(
                        "Buscar una película...",
                        text: $searchText
                    )

                    NavigationLink(
                        value: Destination.results(query)
                    ) {
                        Text("Buscar")
                            .bold()
                            .padding(10)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    .disabled(query.isEmpty)
                }
                .padding()
                .background(.white)
                .cornerRadius(15)
            }

            if let errorMessage = movieViewModel.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundStyle(.black)
        .background(Color.gray.opacity(0.2))
    }
}