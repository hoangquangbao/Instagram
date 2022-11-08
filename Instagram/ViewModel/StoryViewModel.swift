//
//  StoryViewModel.swift
//  Instagram
//
//  Created by lhduc on 05/11/2022.
//

import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var activeStories: [Story] = []
    @Published var isStoryDisplay: Bool = false
    
    private let storyService = StoryService()
    private let userService  = UserService()
    
    init() {
        refresh()
    }
    
    func refresh() {
        storyService.getAll { stories in
            self.stories = stories
            
            for i in 0..<stories.count {
                self.userService.get(by: stories[i].uid) { user in
                    self.stories[i].user = user
                }
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
}
