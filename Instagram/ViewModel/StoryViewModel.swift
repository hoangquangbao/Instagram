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
    
    
    init() {
        refresh()
    }
    
    func refresh() {
        Task {
            self.stories = try await StoryService.getAll()
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
