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

enum Destino: Hashable {
    case ultimas
    case favoritos
    case resultados(String)
    case detalle(Pelicula)
}
