//
//  User.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/5/25.
//

import Foundation

struct User: Identifiable {
    var id: String
    var name: String
    var email: String
    var pinCode: String
    var employeeCategory: EmployeeCategory
}

enum EmployeeCategory: Int {
    case host = 1
    case server = 2
    case manager = 3
    case generalManager = 4
}
