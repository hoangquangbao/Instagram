//
//  StoryService.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import Foundation

struct StoryService: ServiceProtocol {
    typealias ModelType = Story
    static private let _storyRef =  FirebaseManager.shared.firestore.collection(FirebaseConstants.STORY_COLLECTION)
    
    static func get(by id: String) async throws -> Story? {
        return try? await _storyRef.document(id).getDocument().data(as: Story.self)
    }
    
    static func getAll(completion: @escaping ([Story]) -> Void) {
        _storyRef.order(by: "createAt", descending: true).addSnapshotListener { querySnapshot, error in
            Task {
                guard let querySnapshot = querySnapshot else {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                var stories = querySnapshot.documents.compactMap{ try? $0.data(as: Story.self) }
                
                for i in 0..<stories.count {
                    stories[i].user = try await UserService.get(by: stories[i].uid)
                }
                
                completion(stories)
            }
        }
    }
    
    static func create(_ story: Story, completion: @escaping (Bool, Error?) -> Void) {
        do {
            try _storyRef
                .document()
                .setData(from: story) { error in
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
        _storyRef.document(id).updateData([field: data]) { error in
            guard error != nil else {
                completion (false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    static func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        _storyRef.document(id).delete { error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
}
