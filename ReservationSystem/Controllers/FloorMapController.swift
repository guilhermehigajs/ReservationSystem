//
//  FloorMap.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/15/25.
//

import Foundation

class FloorMapController: ObservableObject {
    private static let TAG = Constant.FloorMapController.name
    
    @Published var floors: [Floor] = []
    @Published var selectedLevel: Int?
    @Published var selectedOutsideArea: Bool?
    
    private var database: DatabaseManaging
    
    var availableLevels: [Int] {
        Array(Set(floors.map { $0.number })).sorted()
    }
    
    var availableOutsideOptions: [Bool] {
        guard let selectedLevel = selectedLevel else { return [] }
        let filteredFloors = floors.filter { $0.number == selectedLevel }
        return Array(Set(filteredFloors.map { $0.outsideArea })).sorted { !$0 && $1 }
    }
    
    init(database: DatabaseManaging) {
        self.database = database
    }
    
    func loadFloorInf() {
        database.fetchFloorInf { [weak self] floors in
            DispatchQueue.main.async {
                self?.floors = floors
                print(floors.count)
            }
        }
    }

    
    func fetchTables(_ level: Int, _ inside: Bool, completion: @escaping ([Table]) -> Void) {
        database.fetchTables(level, inside: inside, completion: completion)
    }
}
