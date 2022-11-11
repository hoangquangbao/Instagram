//
//  PostService.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

struct PostService: ServiceProtocol {
    typealias ModelType = Post
    
    private let postRef =  FirebaseManager.shared.firestore.collection(FirebaseConstants.POST_COLLECTION)
    private let userService = UserService()
    
    func get(by id: String, completion: @escaping (Post) -> Void) {
        postRef.document(id).getDocument { snapshot, error in
            
            guard let snapshot = snapshot else { return }
            guard let post = try? snapshot.data(as: Post.self) else { return }
            
            completion(post)
        }
    }
    
    func get(for uid: String, completion: @escaping ([Post]) -> Void) {
    }
    
    func getComments(by id: String, completion: @escaping ([Comment]) -> Void) {
        let commentRef = postRef.document(id).collection(FirebaseConstants.COMMENT_COLLECTION)
        
        commentRef.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            var comments = documents.compactMap { try? $0.data(as: Comment.self) }
            
            for i in 0..<comments.count {
                userService.get(by: comments[i].uid) { user in
                    comments[i].user = user
                }
            }
            
            completion(comments)
        }
    }
    
    func getAll(completion: @escaping ([Post]) -> Void) {
        postRef
            .order(by: "createAt", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                var posts = documents.compactMap { try? $0.data(as: Post.self) }
                
                for i in 0..<posts.count {
                    userService.get(by: posts[i].uid) { user in
                        posts[i].user = user
                    }
                }
                completion(posts)
            }
    }
    
    
    func create(_ post: Post, completion: @escaping (Bool, Error?) -> Void) {
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
    
    func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        postRef.document(id).updateData([field: data]) { error in
            guard error != nil else {
                completion (false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    func update(with id: String, comment: Comment, completion: @escaping (Bool, Error?) -> Void) {
        let commentRef = postRef.document(id).collection(FirebaseConstants.COMMENT_COLLECTION)
        
        do {
            try commentRef.document(comment.id).setData(from: comment) { error in
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
    
    func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        
    }
}
