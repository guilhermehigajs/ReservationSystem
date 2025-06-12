//
//  Order.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/7/25.
//

import Foundation

struct Order: Identifiable {
    var id: String
    var items: [Item]
    var total: Double
}
