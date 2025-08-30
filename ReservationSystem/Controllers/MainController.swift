//
//  MainController.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/9/25.
//

import Foundation

struct MainController {
    private static let TAG = ControllerConstants.Main.name
    
    let user: User
    let databaseManager: DatabaseManaging
       
    init (user: User, database: DatabaseManaging) {
        self.user = user
        self.databaseManager = database
    }
    
    var menuOptions: [MenuOption] {
        var options: [MenuOption] = [.clockIn, .schedule, .payment]

        switch user.employeeCategory {
        case .host:
            options.append(.floorMap)
        case .server:
            options.append(contentsOf: [.analysis, .floorMap])
        case .manager, .generalManager:
            options.append(contentsOf: [.analysis, .floorMap])
        }
        return options
    }
    
    func localizedTitle(for option: MenuOption) -> String {
        switch option {
        case .analysis:
            return NSLocalizedString("analysis", comment: "")
        case .clockIn:
            return NSLocalizedString("clock_in", comment: "")
        case .schedule:
            return NSLocalizedString("schedule", comment: "")
        case .floorMap:
            return NSLocalizedString("floor_map", comment: "")
        case .payment:
            return NSLocalizedString("payment", comment: "")
        }
    }

    func iconName(for option: MenuOption) -> String {
        switch option {
        case .analysis:
            return Constant.Image.Analysis.icon
        case .clockIn:
            return Constant.Image.ClockIn.clockInImage
        case .schedule:
            return Constant.Image.Schedule.icon
        case .floorMap:
            return Constant.Image.FloorMap.icon
        case .payment:
            return Constant.Image.Payment.icon
        }
    }

    func saveLastMenuOption(_ option: MenuOption) {
        UserDefaults.standard.set(option.rawValue, forKey: "lastMenuOption")
    }
}
