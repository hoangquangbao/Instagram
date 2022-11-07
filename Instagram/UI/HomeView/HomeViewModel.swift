//
//  HomeViewModel.swift
//  Instagram
//
//  Created by lhduc on 15/10/2022.
//

import Foundation
class HomeViewModel: ObservableObject {
    let postService = PostService()
    let userService = UserService()
    
    @Published var isStoryDisplay: Bool = false
    @Published var isShowNewPostView: Bool = false
    @Published var isShowNewStoryView: Bool = false
    @Published var isShowOptionForNavigateStoryView: Bool = false
    
}
