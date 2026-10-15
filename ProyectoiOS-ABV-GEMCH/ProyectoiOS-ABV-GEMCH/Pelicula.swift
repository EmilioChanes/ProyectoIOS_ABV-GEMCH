//
//  Pelicula.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import Foundation

struct Pelicula: Hashable {
    let id: Int
    let titulo: String
    let anio: String
    let clasificacion: String
    let categoria: String
    let director: String
    let sinopsis: String
    let reparto: [String]
}

extension Pelicula {
    static var mockMovieHorizon = Pelicula(
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
    )
    
    static var mockMovieJourney = Pelicula(
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
    )
    
    static var mockMovieOportunity = Pelicula(
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
}

enum Destino: Hashable {
    case ultimas
    case favoritos
    case resultados(String)
    case detalle(Pelicula)
}
