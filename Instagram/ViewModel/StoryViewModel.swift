//
//  StoryViewModel.swift
//  Instagram
//
//  Created by lhduc on 05/11/2022.
//

import SwiftUI

@MainActor class StoryViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var activeStories: [Story] = []
    @Published var isStoryDisplay: Bool = false
    
    
    init() {
        getAll()
    }
    
    func getAll() {
        StoryService.getAll { stories in
            Task {
                self.stories = stories
                self.deleteExpiredStory(stories: stories)
            }
        }
    }
    
    func userStories(of uid: String) -> [Story] {
        return self.stories.filter { $0.uid == uid }
    }
    
    func clear() {
        self.isStoryDisplay = false
        self.activeStories = []
    }
    
    func deleteExpiredStory(stories: [Story]) {
        for i in 0..<stories.count {
            if isOver24Hours(storie: stories[i]) {
                if let id = stories[i].id {
                    let uid = stories[i].uid
                    StoryService.delete(with: id) { isSuccess, _ in
                        if isSuccess {
                            if self.userStories(of: uid).isEmpty {
                                UserService.update(with: uid, field: "hasStory", data: false) { isSuccess, error in
                                    if !isSuccess {
                                        print(error?.localizedDescription as Any)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func isOver24Hours(storie: Story) -> Bool {
        let numberOfHours = Calendar.current.dateComponents([.hour], from: storie.createAt.dateValue(), to: Date()).hour
        return numberOfHours! >= 24
    }
}
