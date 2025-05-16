//
//  FloorMapScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/15/25.
//

import SwiftUI

struct FloorMapScreen: View {
    @State private var tables: [Table] = [
        Table(id: UUID(), capacity: 2, number: 10, status: .available, position: CGPoint(x: 100, y: 100)),
        Table(id: UUID(), capacity: 4, number: 11, status: .occupied, position: CGPoint(x: 200, y: 300)),
        Table(id: UUID(), capacity: 3, number: 12, status: .bussing, position: CGPoint(x: 300, y: 300)),
        Table(id: UUID(), capacity: 6, number: 13, status: .orderCheck, position: CGPoint(x: 250, y: 100)),
        Table(id: UUID(), capacity: 7, number: 14, status: .reserved, position: CGPoint(x: 250, y: 200))
    ]
    
    var body: some View {
        ZStack {
            // Fundo do mapa
            Color.gray.opacity(0.1).ignoresSafeArea()
            
            // Renderiza cada mesa
            ForEach($tables) { $table in
                TableView(table: $table)
            }
        }
    }
}

#Preview {
    FloorMapScreen()
}
