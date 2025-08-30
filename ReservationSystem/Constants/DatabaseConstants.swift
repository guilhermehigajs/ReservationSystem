//
//  DatabaseConstants.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/30/25.
//

import Foundation

struct DatabaseConstants {
    static let name = "DatabaseManagerImp"
    
    struct Access {
        static let name = "AccessUsers"
        static let pinCode = "pinCode"
        static let userName = "name"
        static let email = "email"
        static let photoURL = "photoURL"
        static let employeeCategory = "employeeCategory"
    }
    
    struct JobFunctions {
        static let name = "jobFunctions"
        static let function = "function"
        static let selectJobFunction = "select function"
    }
    
    struct Tables {
        static let name = "FloorMapTable"
        static let level = "level"
        static let inside = "inside"
        static let number = "number"
        static let capacity = "capacity"
        static let status = "status"
        static let position = "position"
        
        struct Status {
            static let available = "available"
            static let ocupied = "occupied"
            static let bussing = "bussing"
            static let ordercheck = "ordercheck"
            static let reserved = "reserved"
        }
    }
    
    struct Floor {
        static let name = "floorInformation"
        static let outsideArea = "outsideArea"
        static let number = "number"
    }
}
