//
//  DatabaseManagerImp.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

class DatabaseManagerImp: DatabaseManaging {
    private static let TAG = DatabaseConstants.name
    
    private let db: Firestore
    
    init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    func validateCredentials(_ pin: String, completion: @escaping (Bool, User?) -> Void) {
        db.collection(DatabaseConstants.Access.name)
            .whereField(DatabaseConstants.Access.pinCode, isEqualTo: pin)
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
                    let name = data[DatabaseConstants.Access.userName] as? String,
                    let email = data[DatabaseConstants.Access.email] as? String,
                    let password = data[DatabaseConstants.Access.pinCode] as? String,
                    let categoryRaw = data[DatabaseConstants.Access.employeeCategory] as? Int,
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
        db.collection(DatabaseConstants.Tables.name)
            .whereField(DatabaseConstants.Tables.level, isEqualTo: level)
            .whereField(DatabaseConstants.Tables.inside, isEqualTo: inside)
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
                    
                    guard let number = data[DatabaseConstants.Tables.number] as? Int,
                          let capacity = data[DatabaseConstants.Tables.capacity] as? Int,
                          let statusString = data[DatabaseConstants.Tables.status] as? String,
                          let positionString = data[DatabaseConstants.Tables.position] as? String else {
                        return nil
                    }
                    
                    let id = doc.documentID
                    
                    let status: TableStatus
                    switch statusString.lowercased() {
                    case DatabaseConstants.Tables.Status.available: status = .available
                    case DatabaseConstants.Tables.Status.ocupied: status = .occupied
                    case DatabaseConstants.Tables.Status.bussing: status = .bussing
                    case DatabaseConstants.Tables.Status.ordercheck: status = .orderCheck
                    case DatabaseConstants.Tables.Status.reserved: status = .reserved
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
        db.collection(DatabaseConstants.Floor.name).getDocuments { snapshot, error in
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
                
                guard let number = data[DatabaseConstants.Floor.number] as? Int,
                      let outsideArea = data[DatabaseConstants.Floor.outsideArea] as? Bool else {
                    print("[\(Self.TAG)] " + Constant.Message.Error.invalidDocumentData + " : \(doc.documentID)")
                    return nil
                }
                return Floor(id: doc.documentID, number: number, outsideArea: outsideArea)
            }
            completion(floors)
        }
    }
    
    func addNewUser(_ user: User) {
        let docRef = db.collection(DatabaseConstants.Access.name).document(user.id)
        var data: [String: Any] = [
            DatabaseConstants.Access.userName: user.name,
            DatabaseConstants.Access.email: user.email,
            DatabaseConstants.Access.pinCode: user.pinCode,
            DatabaseConstants.Access.employeeCategory: user.employeeCategory.rawValue
        ]
        
        //        if let photoURL = user.photoURL {
        //            data[Constant.Database.Access.photoURL] = photoURL
        //        }
        
        docRef.setData(data) { error in
            if let error = error {
                print("[\(Self.TAG)] " + Constant.Message.Error.faliedToRegisterNewUser + " : \(error.localizedDescription)")
            } else {
                print("[\(Self.TAG)] Usuário \(user.name) adicionado com sucesso.")
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage, userId: String) async throws -> String {
        guard let data = image.jpegData(compressionQuality: 0.85) else {
            throw NSError(domain: "NewUserScreen", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Falha ao converter imagem para JPEG"])
        }
        let ref = Storage.storage().reference().child("profile_photos/\(userId).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        _ = try await ref.putDataAsync(data, metadata: metadata)
        let url = try await ref.downloadURL()
        return url.absoluteString
    }
    
    func getJobFunctions(completion: @escaping ([String]) -> Void) {
        db.collection(DatabaseConstants.JobFunctions.name)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("[\(Self.TAG)] " + Constant.Message.Error.findingDocuments + " : \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("[\(Self.TAG)] " + Constant.Message.Error.noDocumentsFound)
                    completion([])
                    return
                }
                
                let functions: [String] = documents.compactMap { doc in
                    let data = doc.data()
                    return data[DatabaseConstants.JobFunctions.function] as? String
                }
                completion(functions)
            }
    }
}
