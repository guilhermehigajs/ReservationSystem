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

class DatabaseManagerImp {
    private let db: Firestore
    
    init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    func validateCredentials(_ pin: String, completion: @escaping (Bool) -> Void) {
        db.collection(Constant.Access.collectionName).document(Constant.Access.pinCode).getDocument { documentSnapshot, error in
            if let error = error {
                print("Error finding document: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let documentSnapshot = documentSnapshot else {
                print("Document does not exist")
                completion(false)
                return
            }
            if let safedPin = documentSnapshot.data()?[Constant.Access.pinCode] as? String {
                print(safedPin)
                if safedPin == pin {
                    completion(true)
                } else {
                    print("incorrect pin")
                    completion(false)
                }
            } else {
                print("pin code not founded")
                completion(false)
            }
        }
    }
}
