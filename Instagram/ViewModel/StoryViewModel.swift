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
        Task {
            await refresh()
        }
    }
    
    @MainActor func refresh() async {
        do {
            self.stories = try await StoryService.getAll()
        } catch {
            
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
