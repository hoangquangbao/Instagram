//
//  UserService.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//



class UserService: UserServiceProtocol {
    private let userRef =  FirebaseManager.shared.firestore.collection(FirebaseConstants.USER_COLLECTION)
    
    func fetchUser(with uid: String, completion: @escaping (User) -> Void) {
        userRef.document(uid).getDocument { snapshot, error in
            guard let snapshot = snapshot else { return }
            guard let user = try? snapshot.data(as User.self) else { return }
            
            completion(user)
        }
    }
    
    func fetchAll(completion: @escaping ([User]) -> Void) {
        
    }
    
    func createUser(_ user: User, completion: @escaping (Bool) -> Void) {
        
    }
    
    func updateUser(_ user: User, completion: @escaping (Bool) -> Void) {
        
    }
    
    func deleteUser(with id: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    
}
