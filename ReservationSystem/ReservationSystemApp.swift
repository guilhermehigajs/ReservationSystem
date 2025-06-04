//
//  ReservationSystemApp.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

import SwiftUI
import FirebaseCore

@main
struct ReservationSystemApp: App {
    
    let databaseManager = DatabaseManagerImp()
    
    var body: some Scene {
        WindowGroup {
            ContentView(databaseManager: databaseManager)
        }
    }
}
