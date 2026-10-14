//
//  SecondView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI

struct SecondView: View {
    @Environment(ModeloPeliculas.self) private var modelo

    let destino: Destino

    @Binding var ruta: [Destino]

    @State private var textoFavoritos = ""
    @State private var consultaFavoritos = ""

    private var esPantallaFavoritos: Bool {
        if case .favoritos = destino {
            return true
        }

        return false
    }

    private var titulo: String {
        switch destino {
        case .ultimas:
            return "Últimas películas"

        case .favoritos:
            return "Películas favoritas"

        case .resultados(let consulta):
            return "Coincidencias con \"\(consulta)\""

        case .detalle:
            return "Películas"
        }
    }

    private var peliculasVisibles: [Pelicula] {
        switch destino {
        case .ultimas:
            return modelo.peliculas

        case .favoritos:
            return modelo.buscar(
                consultaFavoritos,
                en: modelo.peliculasFavoritas
            )

        case .resultados(let consulta):
            return modelo.buscar(
                consulta,
                en: modelo.peliculas
            )

        case .detalle:
            return []
        }
    }

    private var mensajeVacio: String {
        if esPantallaFavoritos &&
            modelo.peliculasFavoritas.isEmpty {
            return "Aún no tienes películas favoritas guardadas."
        }

        return "No se encontraron películas que coincidan."
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                EncabezadoView(
                    ruta: $ruta,
                    mostrarBuscador: !esPantallaFavoritos
                )

                VStack(alignment: .leading, spacing: 16) {
                    Text(titulo)
                        .font(.title2)
                        .bold()

                    if esPantallaFavoritos {
                        HStack {
                            Image(systemName: "magnifyingglass")

                            TextField(
                                "Buscar en películas favoritas...",
                                text: $textoFavoritos
                            )

                            Button("Buscar") {
                                consultaFavoritos = textoFavoritos
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }

                    if peliculasVisibles.isEmpty {
                        Text(mensajeVacio)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(
                            peliculasVisibles,
                            id: \.id
                        ) { pelicula in
                            TarjetaPeliculaView(
                                pelicula: pelicula
                            )
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(titulo)
    }
}
