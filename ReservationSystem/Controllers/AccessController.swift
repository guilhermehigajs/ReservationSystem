//
//  AccessController.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

import Foundation

class AccessController {
    private static let TAG = Constant.Controller.accessControllerName
    
    private var database: DatabaseManaging
    
    init(database: DatabaseManaging) {
        self.database = database
    }
    
    func checkAccess(_ pin: String, completion: @escaping (Bool) -> Void) {
        database.validateCredentials(pin) { isValid in
            completion(isValid)
        }
    }
}
