//
//  ViewConstants.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/30/25.
//

import Foundation

struct ViewConstants {
    
    struct ServerView {
        static let title = "Daily Summary"
        static let total = "Total: "
        static let tips = "Total Tips: "
        static let currentTables = "Current tables: "
        static let topSpendingTable = "Most profitable table: "
    }
    
    struct NewUserView {
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
    }
    
    struct ProfilePicturePicker {
        static let title = "Profile picture"
        static let changePicture = "change profile picture"
        static let addPicture = "add picture"
        static let removeImage = "remove picture"
    }
    
    struct FloorMap {
        static let nameScreen = "Floor Map"
        static let title = "Floor Map"
        static let calendar = "calendar"
        static let clock = "clock"
    }
    
    struct Analysis {
        static let nameScreen = "Analysis"
        static let title = "General Analysis"
    }
    
    struct ClockIn {
        static let nameScreen = "Clock In"
        static let shiftControl = "Shift Control"
        static let returnBreak = "Return from Break"
        static let breakShift = "Break"
        static let endShift = "End Shift"
    }
    
    struct Schedule {
        static let nameScreen = "ScheduleScreen"
        static let off = "Off"
        static let scheduleShift = "Scheduled Shift —"
        static let dayOff = "Day off"
    }
    
    struct ShoppingList {
        static let nameScreen = "Shopping List"
        static let generatedList = "Generated List:"
    }
    
    struct Main {
        static let todayShift = "Your Shift Today"
        static let offerShift = "Offer your Shift"
    }
    
    struct Payment {
        static let nameScreen = "Payment"
        static let title = "Payment Overview"
        static let weeklyPerformace = "Weekly Performance"
        static let day = "Day"
        static let expected = "Expected"
        static let type = "Type"
        static let actual = "Actual"
        static let totalExpected = "Expected Total: $"
        static let actualTotal = "Actual Total: $"
    }
}
