//
//  DatabaseManaging.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/2/25.
//

import Foundation

protocol DatabaseManaging {
    func validateCredentials(_ pin: String, completion: @escaping (Bool) -> Void)
    func fetchTables(_ level: Int, inside: Bool, completion: @escaping ([Table]) -> Void)
}

