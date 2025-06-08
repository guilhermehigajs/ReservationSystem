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
    private var user: User
    
    var availableLevels: [Int] {
        Array(Set(floors.map { $0.number })).sorted()
    }
    
    var availableOutsideOptions: [Bool] {
        guard let selectedLevel = selectedLevel else { return [] }
        let filteredFloors = floors.filter { $0.number == selectedLevel }
        return Array(Set(filteredFloors.map { $0.outsideArea })).sorted { !$0 && $1 }
    }
    
    init(database: DatabaseManaging, user: User) {
        self.database = database
        self.user = user
    }
    
    var getAccessLevel: EmployeeCategory {
        user.employeeCategory
    }
    
    func loadFloorInf() {
        database.fetchFloorInf { [weak self] floors in
            DispatchQueue.main.async {
                self?.floors = floors
            }
        }
    }
    
    func fetchTables(_ level: Int, _ inside: Bool, completion: @escaping ([Table]) -> Void) {
        database.fetchTables(level, inside: inside, completion: completion)
    }
}
