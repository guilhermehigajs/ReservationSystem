//
//  FloorMapScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/15/25.
//

import SwiftUI

struct FloorMapScreen: View {
    
    let databaseManager: DatabaseManaging
    private let floorMapController: FloorMapController
    
    @State private var tables: [Table] = []
    
    init(databaseManager: DatabaseManaging) {
        self.databaseManager = databaseManager
        self.floorMapController = FloorMapController(database: databaseManager)
    }
    
    var body: some View {
        ZStack {
            ForEach($tables, id: \.id) { $table in
                TableView(table: $table)
            }
        }
        .ignoresSafeArea()
        .background(Color.gray.opacity(0.2))
        .onAppear {
            floorMapController.fetchTables(0, false) { fetchedTables in
                self.tables = fetchedTables
            }
        }
    }
}

#Preview {
    FloorMapScreen(databaseManager: DatabaseManagerImp())
}
