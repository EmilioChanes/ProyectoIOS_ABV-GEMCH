//
//  SavedMovie.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 05/11/26.
//

import SwiftData

@Model
final class SavedMovie {
    var id: Int
    var title: String
    var year: String
    var posterPath: String?

    init(id: Int, title: String, year: String, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.year = year
        self.posterPath = posterPath
    }
}
