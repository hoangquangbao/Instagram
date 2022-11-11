//
//  UserService.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

import Firebase
import FirebaseFirestoreSwift

class UserService: ServiceProtocol {
    
    typealias ModelType = User
    private let userRef =  FirebaseManager.shared.firestore.collection(FirebaseConstants.USER_COLLECTION)
    
    func get(by id: String, completion: @escaping (User) -> Void) {
        userRef
            .document(id)
            .getDocument { snapshot, error in
                
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                completion(user)
            }
    }
    
    func getAll(completion: @escaping ([User]) -> Void) {
        userRef.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let users = documents.compactMap { try? $0.data(as: User.self)}
            
            completion(users)
        }
    }
    
    func create(_ user: User, completion: @escaping (Bool, Error?) -> Void) {
        do {
            try userRef
                .document(user.id!)
                .setData(from: user) { error in
                    if let error = error {
                        completion(false, error)
                    }
                    else {
                        completion(true, nil)
                    }
                }
        } catch {
            completion(false, error)
        }
    }
    
    func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        userRef.document(id).updateData([field: data]) { error in
            guard error != nil else {
                completion (false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        
    }
    
    
}
