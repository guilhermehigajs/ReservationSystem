//
//  Constant.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

struct Constant {
    static let appName = "Reservation System"
    
    struct Access {
        static let collectionName = "users_pin"
        static let date = "date_account_created"
        static let pinCode = "pin_code"
        static let userId = "user_id"
    }
    
    struct Controller {
        static let accessControllerName = "AccessController"
        static let registerControllerName = "RegisterController"
    }
}
