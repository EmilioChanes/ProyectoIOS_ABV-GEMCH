//
//  Componentes.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import SwiftUI

struct EncabezadoView: View {
    @Binding var ruta: [Destino]

    var mostrarBuscador: Bool = true
    var mostrarHero: Bool = true

    @State private var texto = ""

    private var consulta: String {
        texto.trimmingCharacters(in: .whitespacesAndNewlines) //normalización del texto
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button {
                    ruta.removeAll()
                } label: {
                    Image(systemName: "house")
                        .font(.title)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                }
                .accessibilityLabel("Ir al inicio") //Para accesibilidad

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

            if mostrarHero {
                Text("MovieMap")
                    .font(.largeTitle)
                    .bold()

                Text("Descubre películas y guarda tus favoritas.")
                    .multilineTextAlignment(.center)
            }

            if mostrarBuscador {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField(
                        "Buscar una película...",
                        text: $texto
                    )

                    NavigationLink(
                        value: Destino.resultados(consulta)
                    ) {
                        Text("Buscar")
                            .bold()
                            .padding(10)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    .disabled(consulta.isEmpty) //Para evitar que se pueda buscar sin haber escrito nada
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

struct BotonFavoritoView: View {
    @Environment(ModeloPeliculas.self) private var modelo

    let pelicula: Pelicula

    var body: some View {
        Button {
            modelo.alternarFavorito(pelicula)
        } label: {
            Image(
                systemName: modelo.esFavorita(pelicula)
                    ? "heart.fill"
                    : "heart"
            )
            .font(.title2)
            .foregroundStyle(.red)
            .padding(8)
        }
        .accessibilityLabel(
            modelo.esFavorita(pelicula)
                ? "Quitar \(pelicula.titulo) de favoritos"
                : "Agregar \(pelicula.titulo) a favoritos"
        )
    }
}

struct TarjetaPeliculaView: View {
    let pelicula: Pelicula

    var body: some View {
        VStack(spacing: 8) {
            NavigationLink(
                value: Destino.detalle(pelicula)
            ) {
                VStack(spacing: 8) {
                    Image(systemName: "film")
                        .font(.system(size: 50))
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)

                    Text(pelicula.titulo)
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Text(pelicula.anio)
                        .font(.subheadline)
                }
                .foregroundStyle(.primary)
            }

            BotonFavoritoView(pelicula: pelicula)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}
