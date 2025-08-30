//
//  AnalysisController.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/7/25.
//

import Foundation
import Combine

class AnalysisController: ObservableObject {
    private static let TAG = ControllerConstants.Analysis.name
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var category: EmployeeCategory {
        user.employeeCategory
    }
}
