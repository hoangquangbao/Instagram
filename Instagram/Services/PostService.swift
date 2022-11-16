//
//  PostService.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

import Foundation

struct PostService: ServiceProtocol {
    typealias ModelType = Post
    static private let _postRef =  FirebaseManager.shared.firestore.collection(FirebaseConstants.POST_COLLECTION)
    
    static func get(by id: String) async throws -> Post? {
        let post = try await _postRef.document(id).getDocument().data(as: Post.self)
        guard var post = post else { return nil }
        
        post.user = try await UserService.get(by: post.uid)
        post.comments = try await getComments(with: post.uid)
        return post
    }
    
    func get(for uid: String, completion: @escaping ([Post]) -> Void) {
    }
    
    static func getAll() async throws -> [Post] {
        let documents = try await _postRef.order(by: "createAt", descending: true).getDocuments().documents
        
        var posts: [Post] = documents.compactMap { document in
            try? document.data(as: Post.self)
        }
        
        for i in 0..<posts.count {
            posts[i].user = try await UserService.get(by: posts[i].uid)
            
            if posts[i].likes.isNotEmpty {
                let latestUid = posts[i].likes[posts[i].likeCount - 1]
                posts[i].latestUserLikePost = try await UserService.get(by: latestUid)
            }
        }
        
        return posts
    }
    
    static func getComments(with id: String) async throws -> [Comment]? {
        let commentRef = _postRef.document(id).collection(FirebaseConstants.COMMENT_COLLECTION)
        
        let documents = try await commentRef.order(by: "commentAt", descending: true).getDocuments().documents
        var comments: [Comment] = documents.compactMap { document in
            try? document.data(as: Comment.self)
        }
        
        for i in 0..<comments.count {
            comments[i].user = try await UserService.get(by: comments[i].uid)
        }
        
        return comments
    }
    
    
    static func create(_ post: Post, completion: @escaping (Bool, Error?) -> Void) {
        do {
            try _postRef
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
    
    static func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        _postRef.document(id).updateData([field: data]) { error in
            guard error != nil else {
                completion (false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    static func update(with id: String, comment: Comment, completion: @escaping (Bool, Error?) -> Void) {
        let commentRef = _postRef.document(id).collection(FirebaseConstants.COMMENT_COLLECTION)
        
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
    
    static func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        
    }
}
