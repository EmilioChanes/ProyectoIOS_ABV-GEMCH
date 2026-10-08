//
//  DetallePeliculaView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import SwiftUI

struct DetallePeliculaView: View {
    let pelicula: Pelicula

    @Binding var ruta: [Destino]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                EncabezadoView(
                    ruta: $ruta,
                    mostrarBuscador: false,
                    mostrarHero: false
                )

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(pelicula.titulo)
                            .font(.largeTitle)
                            .bold()

                        Spacer()

                        BotonFavoritoView(pelicula: pelicula)
                    }

                    Image(systemName: "film")
                        .font(.system(size: 90))
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)

                    Text("Año de estreno: \(pelicula.anio)")

                    Text(
                        "Clasificación: \(pelicula.clasificacion)"
                    )

                    Text("Categoría: \(pelicula.categoria)")

                    Text("Director: \(pelicula.director)")

                    Text("Sinopsis")
                        .font(.title2)
                        .bold()

                    Text(pelicula.sinopsis)

                    Text("Reparto principal")
                        .font(.title2)
                        .bold()

                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(
                                pelicula.reparto,
                                id: \.self
                            ) { nombre in
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

                                    Text(nombre)
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
