//
//  Constant.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

struct Constant {
    
    struct Application {
        static let appName = "Malibu Farm"
        static let appLogo = "ReservationSystemLogo"
        static let appVersion = "Version 2.1.4"
    }
    
    struct Image {
        
        struct ProfilePicturePicker {
            static let shape = "person.crop.circle.fill"
            static let systemImage = "camera.fill"
            static let systemImage2 = "trash"
        }
        
        struct FloorMap {
            static let icon = "square.grid.3x3.middle.filled"
        }
        
        struct Analysis {
            static let icon = "chart.bar"
        }
        
        struct ClockIn {
            static let clockIn = "Clock In"
            static let clockInImage = "clock"
            static let endShiftImage = "stop.circle"
            static let returnBreakImage = "play.circle"
            static let breakShiftImage = "pause.circle"
            static let shiftEnded = "🔚 Shift ended"
            static let breakStarted = "☕ Break started"
            static let clockInCompleted = "✅ Clock In completed"
            static let returnBreakCompleted = "▶️ Returned from break"
        }
        
        struct Schedule {
            static let icon = "calendar"
            static let workedHours = "hourglass.bottomhalf.filled"
        }
        
        struct ShoppingList {
            static let icon = "cart"
        }
        
        struct Main {
                static let menuLeft = "sidebar.left"
        }
        
        struct Payment {
            static let icon = "dollarsign.circle.fill"
        }
        
        struct NewUser {
            static let icon = "chevron.down"
        }
    }
    
    struct Message {
        static let selecteFloor = "Selecte the floor"
        static let selectFloorLevel = "Level"
        static let selecteArea = "Selecte the area"
        static let insideArea = "Inside"
        static let outsideArea = "Outside"
        static let enterCode = "Enter code"
        
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
            static let unsupportedCategory = "Category not supported"
            static let faliedToRegisterNewUser = "Fairly to register new user"
            static let wrongCategoryChoosen = "Categoria inválida. Use 1-4 ou host/server/manager/generalManager."
            static let emptyField = "This field is empty, please fill it"
        }
        
        struct Success {
            static let loggedInSuccessfully = "Logged in successfully."
            static let userRegistered = "User successfully registered."
        }
        
        struct AlertDialog {
            static let contactAdmin = "Please, contact administrator."
            static let ok = "OK"
            static let signIn = "Sign in"
        }
    }
    
    struct ImageName {
        static let analysis = "chart.line.uptrend.xyaxis"
    }
}
