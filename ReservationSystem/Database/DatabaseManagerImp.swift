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
    
    func validateCredentials(_ pin: String, completion: @escaping (Bool, User?) -> Void) {
        db.collection(Constant.Database.Access.name)
            .whereField(Constant.Database.Access.pinCode, isEqualTo: pin)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("[\(Self.TAG)] " + Constant.Message.Error.findingDocuments + " : \(error.localizedDescription)")
                    completion(false, nil)
                    return
                }

                guard let document = snapshot?.documents.first else {
                    print("[\(Self.TAG)] " + Constant.Message.Error.noMatchingUserForPin + " : \(pin)")
                    completion(false, nil)
                    return
                }

                let data = document.data()
                guard
                    let name = data[Constant.Database.Access.userName] as? String,
                    let email = data[Constant.Database.Access.email] as? String,
                    let password = data[Constant.Database.Access.pinCode] as? String,
                    let categoryRaw = data[Constant.Database.Access.employeeCategory] as? Int,
                    let category = EmployeeCategory(rawValue: categoryRaw)
                else {
                    print("[\(Self.TAG)] " + Constant.Message.Error.invalidUserDataFormat)
                    completion(false, nil)
                    return
                }

                let user = User(
                    id: document.documentID,
                    name: name,
                    email: email,
                    pinCode: password,
                    employeeCategory: category
                )
                completion(true, user)
            }
    }

    func fetchTables(_ level: Int, inside: Bool, completion: @escaping ([Table]) -> Void) {
        db.collection(Constant.Database.Tables.name)
            .whereField(Constant.Database.Tables.level, isEqualTo: level)
            .whereField(Constant.Database.Tables.inside, isEqualTo: inside)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("[\(Self.TAG)] " + Constant.Message.Error.findingTables + " : \(error.localizedDescription)")
                    completion([])
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let tables: [Table] = documents.compactMap { doc -> Table? in
                    let data = doc.data()

                    guard let number = data[Constant.Database.Tables.number] as? Int,
                          let capacity = data[Constant.Database.Tables.capacity] as? Int,
                          let statusString = data[Constant.Database.Tables.status] as? String,
                          let positionString = data[Constant.Database.Tables.position] as? String else {
                        return nil
                    }

                    let id = doc.documentID

                    let status: TableStatus
                    switch statusString.lowercased() {
                    case Constant.Database.Tables.Status.available: status = .available
                    case Constant.Database.Tables.Status.ocupied: status = .occupied
                    case Constant.Database.Tables.Status.bussing: status = .bussing
                    case Constant.Database.Tables.Status.ordercheck: status = .orderCheck
                    case Constant.Database.Tables.Status.reserved: status = .reserved
                    default:
                        print("[\(Self.TAG)] " + Constant.Message.Error.invalidStatus + " : \(statusString)")
                        return nil
                    }

                    let components = positionString.split(separator: ",")
                    guard components.count == 2,
                          let x = Double(components[0]),
                          let y = Double(components[1]) else {
                        print("[\(Self.TAG)] " + Constant.Message.Error.invalidPosition + " : \(positionString)")
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
                print("[\(Self.TAG)] " + Constant.Message.Error.findingFloors + " : \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("[\(Self.TAG)] " + Constant.Message.Error.noDocumentsFound)
                completion([])
                return
            }

            let floors: [Floor] = documents.compactMap { doc -> Floor? in
                let data = doc.data()

                guard let number = data[Constant.Database.Floor.number] as? Int,
                      let outsideArea = data[Constant.Database.Floor.outsideArea] as? Bool else {
                    print("[\(Self.TAG)] " + Constant.Message.Error.invalidDocumentData + " : \(doc.documentID)")
                    return nil
                }
                return Floor(id: doc.documentID, number: number, outsideArea: outsideArea)
            }
            completion(floors)
        }
    }
    
    func addNewUser(_ user: User) {
        let docRef = db.collection(Constant.Database.Access.name).document(user.id)
        let data: [String: Any] = [
            Constant.Database.Access.userName: user.name,
            Constant.Database.Access.email: user.email,
            Constant.Database.Access.pinCode: user.pinCode,
            Constant.Database.Access.employeeCategory: user.employeeCategory.rawValue
        ]
        
        docRef.setData(data) { error in
            if let error = error {
                print("[\(Self.TAG)] " + Constant.Message.Error.faliedToRegisterNewUser + " : \(error.localizedDescription)")
            } else {
                print("[\(Self.TAG)] Usuário \(user.name) adicionado com sucesso.")
            }
        }
    }

}
