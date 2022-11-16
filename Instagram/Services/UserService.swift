//
//  UserService.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserService: ServiceProtocol {
    
    typealias ModelType = User
    static private let _userRef =  FirebaseManager.shared.firestore.collection(FirebaseConstants.USER_COLLECTION)
    
    static func get(by id: String) async throws -> User? {
        return try await _userRef.document(id).getDocument().data(as: User.self)
    }
    
    static func getAll() async throws -> [User] {
        let documents = try await _userRef.getDocuments().documents
        
        return documents.compactMap { try? $0.data(as: User.self) }
    }
    
    static func create(_ user: User, completion: @escaping (Bool, Error?) -> Void) {
        do {
            try _userRef
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
    
    static func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        _userRef.document(id).updateData([field: data]) { error in
            if let error = error {
                completion(false, error)
            }
            else {
                completion(true, nil)
            }
        }
    }
    
    static func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        
    }
}
