//
//  DatabaseManagerImp.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class DatabaseManagerImp: DatabaseManaging {
    private static let TAG = Constant.Database.name
    
    private let db: Firestore
    
    init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    func validateCredentials(_ pin: String, completion: @escaping (Bool) -> Void) {
        db.collection(Constant.Database.Access.name)
            .whereField(Constant.Database.Access.pinCode, isEqualTo: pin)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("[\(Self.TAG)] Error getting documents: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                guard let documents = snapshot?.documents, !documents.isEmpty else {
                    print("[\(Self.TAG)] No matching documents found for pin: \(pin)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    func fetchTables(_ level: Int, inside: Bool, completion: @escaping ([Table]) -> Void) {
        db.collection(Constant.Database.Tables.name)
            .whereField(Constant.Database.Tables.level, isEqualTo: level)
            .whereField(Constant.Database.Tables.inside, isEqualTo: inside)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("[\(Self.TAG)] Error finding tables: \(error.localizedDescription)")
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let tables: [Table] = documents.compactMap { doc -> Table? in
                    let data = doc.data()

                    guard let number = data["number"] as? Int,
                          let capacity = data["capacity"] as? Int,
                          let statusString = data["status"] as? String,
                          let positionString = data["position"] as? String else {
                        return nil
                    }

                    let id = doc.documentID


                    let status: TableStatus
                    switch statusString.lowercased() {
                    case "available": status = .available
                    case "occupied": status = .occupied
                    case "bussing": status = .bussing
                    case "ordercheck": status = .orderCheck
                    case "reserved": status = .reserved
                    default:
                        print("[\(Self.TAG)] Invalid status: \(statusString)")
                        return nil
                    }

                    let components = positionString.split(separator: ",")
                    guard components.count == 2,
                          let x = Double(components[0]),
                          let y = Double(components[1]) else {
                        print("[\(Self.TAG)] Invalid position: \(positionString)")
                        return nil
                    }
                    let position = CGPoint(x: x, y: y)

                    return Table(
                        id: id,
                        capacity: capacity,
                        number: number,
                        status: status,
                        position: position
                    )
                }
                completion(tables)
            }
    }
    
    func fetchFloorInf(completion: @escaping ([Floor]) -> Void) {
        db.collection(Constant.Database.Floor.name).getDocuments { snapshot, error in
            if let error = error {
                print("[\(Self.TAG)] Error finding floors: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("[\(Self.TAG)] No documents found.")
                completion([])
                return
            }

            let floors: [Floor] = documents.compactMap { doc -> Floor? in
                let data = doc.data()

                guard let number = data["number"] as? Int,
                      let outsideArea = data["outsideArea"] as? Bool else {
                    print("[\(Self.TAG)] invalid document data: \(doc.documentID)")
                    return nil
                }
                return Floor(id: doc.documentID, number: number, outsideArea: outsideArea)
            }
            completion(floors)
        }
    }
}
