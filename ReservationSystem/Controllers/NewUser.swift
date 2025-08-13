//
//  NewUserController.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/12/25.
//

import Foundation

class NewUserController {
    private static let TAG = Constant.NewUser.Controller.name
    
    private var database: DatabaseManaging
    
    init(database: DatabaseManaging) {
        self.database = database
    }
    
    func registerNewUser(_ user: User) {
        database.addNewUser(user)
    }
    
    func validateUserInputs(_ input: String) -> Bool {
        return !input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
