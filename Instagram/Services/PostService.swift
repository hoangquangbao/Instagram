//
//  PostService.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

struct PostService: ServiceProtocol {
    typealias ModelType = Post
    
    private let postRef =  FirebaseManager.shared.firestore.collection(FirebaseConstants.POST_COLLECTION)
    
    func get(by id: String, completion: @escaping (Post) -> Void) {
        postRef.document(id).getDocument { snapshot, error in
            
            guard let snapshot = snapshot else { return }
            guard let post = try? snapshot.data(as: Post.self) else { return }
            
            completion(post)
        }
    }
    
    func get(for uid: String, completion: @escaping ([Post]) -> Void) {
        
    }
    
    func getAll(completion: @escaping ([Post]) -> Void) {
        postRef
            .order(by: "createAt", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap { try? $0.data(as: Post.self) }
                
                completion(posts)
            }
    }
    
    
    func create(_ post: Post, completion: @escaping(Bool, Error?) -> Void) {
        do {
            try postRef
                .document()
                .setData(from: post) { error in
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
    
    func update(_ post: Post, completion: @escaping (Bool, Error?) -> Void) {
        
    }
    
    func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        
    }
}
