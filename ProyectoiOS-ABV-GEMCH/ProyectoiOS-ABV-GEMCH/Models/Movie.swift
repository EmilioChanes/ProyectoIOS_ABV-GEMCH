//
//  Pelicula.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 08/10/26.
//

import Foundation

struct Movie: Hashable {
    let id: Int
    let title: String
    let year: String
    let classification: String
    let category: String
    let director: String
    let synopsis: String
    let cast: [String]
    let rating: Double?
}

extension Movie {
    static var mockMovieHorizon = Movie(
        id: -1,
        title: "Horizonte",
        year: "2026",
        classification: "B",
        category: "Ciencia ficción",
        director: "Director",
        synopsis: """
        Una tripulación recibe una señal desconocida y decide
        investigar su origen.
        """,
        cast: ["Intérprete A", "Intérprete B"],
        rating: 8.2
    )

    static var mockMovieJourney = Movie(
        id: -2,
        title: "El último viaje",
        year: "2025",
        classification: "A",
        category: "Aventura",
        director: "Director",
        synopsis: """
        Dos amigos emprenden un viaje que cambia su manera
        de entender el mundo.
        """,
        cast: ["Intérprete C", "Intérprete D"],
        rating: 7.5
    )

    static var mockMovieOpportunity = Movie(
        id: -3,
        title: "Una nueva oportunidad",
        year: "2024",
        classification: "B",
        category: "Drama",
        director: "Directora",
        synopsis: """
        Una persona regresa a su ciudad para resolver asuntos
        pendientes y comenzar una nueva etapa.
        """,
        cast: ["Intérprete E", "Intérprete F"],
        rating: 7.8
    )
}

enum Destination: Hashable {
    case latest
    case favorites
    case results(String)
    case detail(Movie)
    case favoriteDetail(MovieFavorite)
}
