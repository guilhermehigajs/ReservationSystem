//
//  Constant.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

struct Constant {
    static let appName = "Reservation System"
        
    struct Database {
        static let name = "DatabaseManagerImp"
        
        struct Access {
            static let name = "users_pin"
            static let date = "date_account_created"
            static let pinCode = "pin_code"
            static let userId = "user_id"
        }
        
        struct Tables {
            static let name = "FloorMapTable"
            static let level = "level"
            static let inside = "inside"
        }
    }
        
    struct AccessController {
        static let name = "AccessController"
    }
    
    struct FloorMapController {
        static let name = "FloorMapController"
    }
}
