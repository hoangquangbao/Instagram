//
//  HomeViewModel.swift
//  Instagram
//
//  Created by lhduc on 15/10/2022.
//

import Foundation
class HomeViewModel: ObservableObject {
    @Published var isStoryDisplay: Bool = false
    @Published var isShowNewPostView: Bool = false
    @Published var isShowNewStoryView: Bool = false
    @Published var isShowOptionForNavigateStoryView: Bool = false
    @Published var isShowCallView = false
    
}
