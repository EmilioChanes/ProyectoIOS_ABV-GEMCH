//
//  ContentView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var service: movieServices
    @State private var path: [Destination] = []

    init(context: ModelContext) {
        _service = State(
            initialValue: movieServices(context: context)
        )
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    HeaderView(path: $path)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Últimas películas")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            NavigationLink(
                                "Ver más",
                                value: Destination.latest
                            )
                        }
                        
                        ScrollView(.horizontal) {
                            HStack(alignment: .top, spacing: 16) {
                                ForEach(
                                    service.movies,
                                    id: \.id
                                ) { movie in
                                    MovieCardView(
                                        movie: movie
                                    )
                                    .frame(width: 180)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Películas favoritas")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            NavigationLink(
                                "Ver más",
                                value: Destination.favorites
                            )
                        }
                        
                        if service.favoriteMovies.isEmpty {
                            Text(
                                "Aún no tienes películas favoritas guardadas..."
                            )
                            .foregroundStyle(.secondary)
                        } else {
                            ScrollView(.horizontal) {
                                HStack(
                                    alignment: .top,
                                    spacing: 16
                                ) {
                                    ForEach(
                                        service.favoriteMovies,
                                        id: \.id
                                    ) { movie in
                                        MovieCardView(
                                            movie: movie
                                        )
                                        .frame(width: 180)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .latest:
                    MovieListView(
                        destination: destination,
                        service: service,
                        path: $path
                    )
                    
                case .favorites:
                    MovieListView(
                        destination: destination,
                        service: service,
                        path: $path
                    )
                    
                case .results:
                    MovieListView(
                        destination: destination,
                        service: service,
                        path: $path
                    )
                    
                case .detail(let movie):
                    MovieDetailView(
                        movie: movie,
                        path: $path
                    )
                }
            }
        }
        .environment(service)
    }
}

#Preview {
    let schema = Schema([
        SavedMovie.self
    ])

    let configuration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: true
    )

    let container = try! ModelContainer(
        for: schema,
        configurations: [configuration]
    )

    let context = ModelContext(container)

    ContentView(context: context)
}
