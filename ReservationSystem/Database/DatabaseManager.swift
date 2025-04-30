//
//  DatabaseManager.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

import Foundation

class DatabaseManager {
    
    private let dataBaseImp = DatabaseManagerImp()
    
    func validateCredentials(_ pin: String, completion: @escaping (Bool) -> Void) {
        return dataBaseImp.validateCredentials(pin, completion: completion)
    }
}
