//
//  Item.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/7/25.
//

import Foundation

struct Item: Identifiable {
    var id: String
    var name: String
    var price: Double
    var description: [Ingridient]
}
