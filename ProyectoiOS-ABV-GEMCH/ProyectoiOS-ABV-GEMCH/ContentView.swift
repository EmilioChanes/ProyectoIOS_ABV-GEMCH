//
//  ContentView.swift
//  ProyectoiOS-ABV-GEMCH
//
//  Created by Facultad de Contaduría y Administración on 24/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State var text: String = ""

    var body: some View {

        
        VStack{
            VStack{
                HStack{
                    Button{
                        print("Home")
                    } label: {
                        Image(systemName: "house")
                            .bold()
                            .padding()
                            .font(.system(size: 30))
                            .foregroundStyle(.black)
                            .background(.white)
                            .cornerRadius(50)
                    }
                    Spacer()
                    Button{
                        print("NavHamburguer")
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .bold()
                            .padding()
                            .font(.system(size: 30))
                            .foregroundStyle(.black)
                            .background(.white)
                            .cornerRadius(5)
                    }
                }
                
                Text("MovieMap")
                    .bold()
                    .font(.largeTitle)
                Text("Descripción de la app")
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 35))
                        .foregroundStyle(.black)
                        .padding(.all, 5)
                    
                    TextField(text: $text) {
                        Text("Buscar una película...")
                    }
                    .bold()
                    
                    Button {
                        print("Si")
                    } label: {
                        Text("Buscar")
                            .bold()
                            .padding()
                            .foregroundStyle(.white)
                            .background(.cyan)
                            .cornerRadius(10)
                    }
                    .cornerRadius(20)
                    .padding()
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            }
            .background(Color.gray)
            Spacer()
            
            
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
