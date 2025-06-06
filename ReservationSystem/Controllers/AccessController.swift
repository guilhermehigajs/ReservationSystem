//
//  AccessController.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

import Foundation

class AccessController {
    private static let TAG = Constant.AccessController.name
    
    private var database: DatabaseManaging
    
    init(database: DatabaseManaging) {
        self.database = database
    }
    
    func checkAccess(_ pin: String, completion: @escaping (Bool, User?) -> Void) {
        database.validateCredentials(pin) { isValid, user in
            completion(isValid, user)
        }
    }
}
