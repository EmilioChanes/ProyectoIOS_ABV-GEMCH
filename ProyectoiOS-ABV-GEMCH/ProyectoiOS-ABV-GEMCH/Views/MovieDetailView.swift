//
//  DetallePeliculaView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    @Binding var path: [Destination]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeaderView(
                    path: $path,
                    showSearchBar: false,
                    showHero: false
                )

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(movie.title)
                            .font(.largeTitle)
                            .bold()

                        Spacer()

                        FavoriteButtonView(movie: movie)
                    }

                    Image(systemName: "film")
                        .font(.system(size: 90))
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)

                    Text("Año de estreno: \(movie.year)")

                    Text(
                        "Clasificación: \(movie.classification)"
                    )

                    Text("Categoría: \(movie.category)")

                    Text("Director: \(movie.director)")

                    Text("Sinopsis")
                        .font(.title2)
                        .bold()

                    Text(movie.synopsis)

                    Text("Reparto principal")
                        .font(.title2)
                        .bold()

                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(
                                movie.cast,
                                id: \.self
                            ) { name in
                                VStack(spacing: 8) {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 40))
                                        .frame(
                                            width: 100,
                                            height: 100
                                        )
                                        .background(
                                            Color.gray.opacity(0.2)
                                        )
                                        .cornerRadius(12)

                                    Text(name)
                                        .multilineTextAlignment(
                                            .center
                                        )
                                }
                                .frame(width: 120)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
