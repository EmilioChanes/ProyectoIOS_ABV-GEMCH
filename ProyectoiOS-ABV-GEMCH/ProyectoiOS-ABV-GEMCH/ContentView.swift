//
//  ContentView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var modelo = ModeloPeliculas() //catálogo de películas
    @State private var ruta: [Destino] = [] //Guarda el recorrido de navegación

    var body: some View {
        NavigationStack(path: $ruta) {
            ScrollView {
                VStack(spacing: 20) {
                    EncabezadoView(ruta: $ruta)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Últimas películas")
                                .font(.title2)
                                .bold()

                            Spacer()

                            NavigationLink(
                                "Ver más",
                                value: Destino.ultimas
                            )
                        }

                        ScrollView(.horizontal) {
                            HStack(alignment: .top, spacing: 16) {
                                ForEach(
                                    modelo.peliculas,
                                    id: \.id
                                ) { pelicula in
                                    TarjetaPeliculaView(
                                        pelicula: pelicula
                                    )
                                    .frame(width: 180)
                                }
                            }
                        }

                        HStack {
                            Text("Películas favoritas")
                                .font(.title2)
                                .bold()

                            Spacer()

                            NavigationLink(
                                "Ver más",
                                value: Destino.favoritos
                            )
                        }

                        if modelo.peliculasFavoritas.isEmpty {
                            Text(
                                "Aún no tienes películas favoritas guardadas..."
                            )
                            .foregroundStyle(.secondary)
                        } else {
                            ScrollView(.horizontal) {
                                HStack(
                                    alignment: .top,
                                    spacing: 16
                                ) {
                                    ForEach(
                                        modelo.peliculasFavoritas,
                                        id: \.id
                                    ) { pelicula in
                                        TarjetaPeliculaView(
                                            pelicula: pelicula
                                        )
                                        .frame(width: 180)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(for: Destino.self) { destino in
                switch destino {
                case .ultimas:
                    SecondView(
                        destino: destino,
                        ruta: $ruta
                    )

                case .favoritos:
                    SecondView(
                        destino: destino,
                        ruta: $ruta
                    )

                case .resultados:
                    SecondView(
                        destino: destino,
                        ruta: $ruta
                    )

                case .detalle(let pelicula):
                    DetallePeliculaView(
                        pelicula: pelicula,
                        ruta: $ruta
                    )
                }
            }
        }
        .environment(modelo)
    }
}

#Preview {
    ContentView()
}
