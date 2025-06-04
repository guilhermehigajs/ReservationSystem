//
//  Table.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/15/25.
//

import Foundation

struct Table: Identifiable {
    let id: String
    var capacity: Int
    let number: Int
    var status: TableStatus
    var position: CGPoint
}

enum TableStatus {
    case available
    case occupied
    case bussing
    case orderCheck
    case reserved
}
