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
        static let addNewUserButtomMessage = "Register new user"
    }
    
    struct NewUser {
        static let title = "Register new user"
        static let userName = "Name"
        static let userEmail = "Email"
        static let userPin = "Pin"
        static let userCategory = "Category/Role"
        static let addUserButtom = "Add User"
        static let cancelUserButtom = "Cancel"
        static let nameMissing = "name is missing"
        static let emailMissing = "email is missing"
        static let pinMissing = "pin is missing"
        static let roleMissing = "role is missing"
        
        
        struct Controller {
            static let name = "NewUserController"
        }
    }
    
    struct FloorMapController {
        static let name = "FloorMapController"
        static let nameScreen = "Floor Map"
        static let title = "Floor Map"
        static let calendar = "calendar"
        static let clock = "clock"
        static let icon = "square.grid.3x3.middle.filled"
    }
    
    struct AnalysisController {
        static let nameScreen = "Analysis"
        static let name = "AnalysisController"
        static let title = "General Analysis"
        static let icon = "chart.bar"
    }
    
    struct ClockInController {
        static let nameScreen = "Clock In"
        static let shiftControl = "Shift Control"
        static let returnBreak = "Return from Break"
        static let returnBreakImage = "play.circle"
        static let breakShift = "Break"
        static let breakShiftImage = "pause.circle"
        static let endShift = "End Shift"
        static let endShiftImage = "stop.circle"
        static let clockIn = "Clock In"
        static let clockInImage = "clock"
        static let clockInCompleted = "✅ Clock In completed"
        static let breakStarted = "☕ Break started"
        static let returnBreakCompleted = "▶️ Returned from break"
        static let shiftEnded = "🔚 Shift ended"
    }
    
    struct MainController {
        static let name = "MainController"
        static let menuLeft = "sidebar.left"
        static let todayShift = "Your Shift Today"
        static let offerShift = "Offer your Shift"
    }
    
    struct ScheduleController {
        static let nameScreen = "ScheduleScreen"
        static let name = "Schedule"
        static let icon = "calendar"
        static let off = "Off"
        static let workedHours = "hourglass.bottomhalf.filled"
        static let scheduleShift = "Scheduled Shift —"
        static let dayOff = "Day off"
    }
    
    struct ShoppingListController {
        static let nameScreen = "Shopping List"
        static let icon = "cart"
        static let generatedList = "Generated List:"
        static let generatedList2 = "Generated List"

    }
    
    struct PaymentController {
        static let nameScreen = "Payment"
        static let icon = "dollarsign.circle.fill"
        static let title = "Payment Overview"
        static let weeklyPerformace = "Weekly Performance"
        static let day = "Day"
        static let expected = "Expected"
        static let type = "Type"
        static let actual = "Actual"
        static let totalExpected = "Expected Total: $"
        static let actualTotal = "Actual Total: $"
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
    
    struct ServerView {
        static let title = "Daily Summary"
        static let total = "Total: "
        static let tips = "Total Tips: "
        static let currentTables = "Current tables: "
        static let topSpendingTable = "Most profitable table: "
    }
}
