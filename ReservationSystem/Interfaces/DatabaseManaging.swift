//
//  DatabaseManaging.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/2/25.
//

import Foundation
import UIKit

protocol DatabaseManaging {
    func validateCredentials(_ pin: String, completion: @escaping (Bool, User?) -> Void)
    func fetchTables(_ level: Int, inside: Bool, completion: @escaping ([Table]) -> Void)
    func fetchFloorInf(completion: @escaping ([Floor]) -> Void)
    func addNewUser(_ user: User)
    func uploadProfileImage(_ image: UIImage, userId: String) async throws -> String
}

