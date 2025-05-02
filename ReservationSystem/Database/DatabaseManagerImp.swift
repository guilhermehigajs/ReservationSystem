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
    private let db: Firestore
    
    init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    func validateCredentials(_ pin: String, completion: @escaping (Bool) -> Void) {
        db.collection(Constant.Access.collectionName)
            .whereField(Constant.Access.pinCode, isEqualTo: pin)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                guard let documents = snapshot?.documents, !documents.isEmpty else {
                    print("No matching documents found for pin: \(pin)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
}
