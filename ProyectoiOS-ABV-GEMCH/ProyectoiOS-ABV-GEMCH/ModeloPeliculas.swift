//
//  Pelicula.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import Observation
import Foundation

@Observable
class ModeloPeliculas {
    let peliculas: [Pelicula] = [
        Pelicula.mockMovieHorizon,
        Pelicula.mockMovieJourney,
        Pelicula.mockMovieOportunity
    ]

    var favoritos: [Pelicula] = []

    var peliculasFavoritas: [Pelicula] {
        favoritos
    }

    func esFavorita(_ pelicula: Pelicula) -> Bool {
        favoritos.contains { favorita in
            favorita.id == pelicula.id
        }
    }

    func alternarFavorito(_ pelicula: Pelicula) {
        if esFavorita(pelicula) {
            favoritos.removeAll { favorita in
                favorita.id == pelicula.id
            }
        } else {
            favoritos.append(pelicula)
        }
    }

    func buscar(
        _ texto: String,
        en lista: [Pelicula]
    ) -> [Pelicula] {
        let consulta = texto
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !consulta.isEmpty else {
            return lista
        }

        return lista.filter { pelicula in
            pelicula.titulo.lowercased().contains(consulta)
        }
    }
}
