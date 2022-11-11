//
//  StoryService.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import Foundation

struct StoryService: ServiceProtocol {
    typealias ModelType = Story
    
    private let userService = UserService()
    private let storyRef =  FirebaseManager.shared.firestore.collection(FirebaseConstants.STORY_COLLECTION)
    
    func get(by id: String, completion: @escaping (Story) -> Void) {
        storyRef.document(id).getDocument { snapshot, error in
            guard let snapshot = snapshot else { return }
            guard let story = try? snapshot.data(as: Story.self) else { return }
            completion(story)
        }
    }
    
    func getAll(completion: @escaping ([Story]) -> Void) {
        storyRef.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            var stories = documents.compactMap { try? $0.data(as: Story.self) }
            
            for i in 0..<stories.count {
                userService.get(by: stories[i].uid) { user in
                    stories[i].user = user
                }
            }
            
            completion(stories)
        }
    }
    
    func create(_ story: Story, completion: @escaping (Bool, Error?) -> Void) {
        do {
            try storyRef
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
    
    func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        storyRef.document(id).updateData([field: data]) { error in
            guard error != nil else {
                completion (false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        return
    }
    
}
