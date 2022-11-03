//
//  StoryService.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import Foundation

struct StoryService: ServiceProtocol {
    typealias ModelType = Story
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
            let stories = documents.compactMap { try? $0.data(as: Story.self)}
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
    
    func update(_ story: Story, completion: @escaping (Bool, Error?) -> Void) {
        <#code#>
    }
    
    func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        <#code#>
    }
    
}
