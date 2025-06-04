//
//  FloorMap.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/15/25.
//

import Foundation

class FloorMapController {
    private static let TAG = Constant.FloorMapController.name
    
    private var database: DatabaseManaging
    
    init(database: DatabaseManaging) {
        self.database = database
    }
    
    func fetchTables(_ level: Int, _ inside: Bool, completion: @escaping ([Table]) -> Void) {
        database.fetchTables(level, inside: inside, completion: completion)
    }
}
