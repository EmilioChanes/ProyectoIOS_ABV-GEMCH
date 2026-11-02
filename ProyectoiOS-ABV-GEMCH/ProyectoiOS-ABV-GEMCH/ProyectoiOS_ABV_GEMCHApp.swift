//
//  ProyectoiOS_ABV_GEMCHApp.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI
import SwiftData

@main
struct ProyectoiOS_ABV_GEMCHApp: App {
    let context: ModelContext = {
        let schema = Schema([
            SavedMovie.self
        ])

        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            let container = try ModelContainer(
                for: schema,
                configurations: [configuration]
            )

            return ModelContext(container)
        } catch {
            fatalError(
                "Could not create ModelContainer: \(error)"
            )
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(context: context)
        }
    }
}