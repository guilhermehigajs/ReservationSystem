//
//  Constant.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

struct Constant {
    struct Application {
        static let appName = "Reservation System"
        static let appLogo = "ReservationSystemLogo"
        static let appVersion = "Version 1.0"
    }
    
    struct Database {
        static let name = "DatabaseManagerImp"
        
        struct Access {
            static let name = "AccessUsers"
            static let pinCode = "pinCode"
            static let userName = "name"
            static let email = "email"
            static let employeeCategory = "employeeCategory"
            
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
        
    struct AccessController {
        static let name = "AccessController"
    }
    
    struct FloorMapController {
        static let name = "FloorMapController"
    }
    
    struct Message {
        static let selecteFloor = "Selecte the floor"
        static let selectFloorLevel = "Level"
        static let selecteArea = "Selecte the area"
        static let insideArea = "Inside"
        static let outsideArea = "Outside"
        
        struct Error {
            static let failedValidateCredentials = "Failed to validate credentials."
            static let credentialsNotRecognized = "Credentials not recognized"
            static let noDocumentsFound = "No documents found."
            static let invalidDocumentData = "Invalid document data."
            static let findingFloors = "Error finding floors"
            static let invalidPosition = "Invalid position"
            static let invalidStatus = "Invalid status"
            static let findingTables = "Error finding tables"
            static let findingDocuments = "Error getting documents"
            static let noMatchingUserForPin = "No matching documents found for pin"
            static let invalidUserDataFormat = "Invalid user data format"
        }
        
        struct Success {
            static let loggedInSuccessfully = "Logged in successfully."
        }
        
        struct AlertDialog {
            static let contactAdmin = "Please, contact administrator."
            static let ok = "OK"
            static let signIn = "Sign in"
        }
    }
}
