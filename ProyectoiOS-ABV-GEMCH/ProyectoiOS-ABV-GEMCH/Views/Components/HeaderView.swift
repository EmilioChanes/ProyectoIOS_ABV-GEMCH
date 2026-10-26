//
//  HeaderView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 26/10/26.
//

import SwiftUI

struct HeaderView: View {
    @Binding var path: [Destination]

    var showSearchBar: Bool = true
    var showHero: Bool = true

    @State private var searchText = ""

    private var query: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        VStack(spacing: 12) {
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

                Button {
                    print("NavHamburguer")
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                }
                .accessibilityLabel("Menú")
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
        }
        .padding()
        .foregroundStyle(.black)
        .background(Color.gray.opacity(0.2))
    }
}

