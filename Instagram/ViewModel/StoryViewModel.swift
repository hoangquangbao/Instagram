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
            deleteExpiredStory(stories: stories)
        } catch {
            print(error.localizedDescription)
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
                        StoryService.delete(with: id) { isSuccess, _ in
                            if isSuccess {
                                    if self.userStories(of: stories[i].uid).isEmpty {
                                        UserService.update(with: stories[i].uid, field: "hasStory", data: false) { isSuccess, error in
                                            if !isSuccess {
                                                print(error?.localizedDescription as Any)
                                            }
                                        }
                                    }
                                self.stories.remove(at: i)
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
