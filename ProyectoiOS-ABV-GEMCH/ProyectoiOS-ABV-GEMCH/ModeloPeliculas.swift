//
//  ModeloPeliculas.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import Observation
import Foundation

@Observable
class ModeloPeliculas {
    let peliculas: [Pelicula] = [
        Pelicula(
            id: 1,
            titulo: "Horizonte",
            anio: "2026",
            clasificacion: "B",
            categoria: "Ciencia ficción",
            director: "Director",
            sinopsis: """
            Una tripulación recibe una señal desconocida y decide
            investigar su origen.
            """,
            reparto: ["Intérprete A", "Intérprete B"]
        ),
        Pelicula(
            id: 2,
            titulo: "El último viaje",
            anio: "2025",
            clasificacion: "A",
            categoria: "Aventura",
            director: "Director",
            sinopsis: """
            Dos amigos emprenden un viaje que cambia su manera
            de entender el mundo.
            """,
            reparto: ["Intérprete C", "Intérprete D"]
        ),
        Pelicula(
            id: 3,
            titulo: "Una nueva oportunidad",
            anio: "2024",
            clasificacion: "B",
            categoria: "Drama",
            director: "Directora",
            sinopsis: """
            Una persona regresa a su ciudad para resolver asuntos
            pendientes y comenzar una nueva etapa.
            """,
            reparto: ["Intérprete E", "Intérprete F"]
        )
    ]

    var favoritos: [Int] = []

    var peliculasFavoritas: [Pelicula] {
        peliculas.filter { pelicula in
            favoritos.contains(pelicula.id)
        }
    }

    func esFavorita(_ pelicula: Pelicula) -> Bool {
        favoritos.contains(pelicula.id)
    }

    func alternarFavorito(_ pelicula: Pelicula) {
        if esFavorita(pelicula) {
            favoritos.removeAll { id in
                id == pelicula.id
            }
        } else {
            favoritos.append(pelicula.id)
        }
    }

    func buscar(
        _ texto: String,
        en lista: [Pelicula]
    ) -> [Pelicula] {
        let consulta = texto
            .trimmingCharacters(in: .whitespacesAndNewlines) //normalización del texto
            .lowercased()

        guard !consulta.isEmpty else {
            return lista
        }

        return lista.filter { pelicula in
            pelicula.titulo.lowercased().contains(consulta)
        }
    }
}
