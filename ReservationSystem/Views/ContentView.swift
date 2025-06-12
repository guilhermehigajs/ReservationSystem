//
//  ContentView.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    let databaseManager: DatabaseManaging

    var body: some View {
        NavigationStack {
            AccessScreen(databaseManager: databaseManager)
        }
    }
}


#Preview {
    ContentView(databaseManager: DatabaseManagerImp())
}
