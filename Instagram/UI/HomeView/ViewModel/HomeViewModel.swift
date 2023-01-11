//
//  HomeViewModel.swift
//  Instagram
//
//  Created by lhduc on 15/10/2022.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var isShowToast: Bool = false
    @Published var isStoryDisplay: Bool = false
    @Published var isShowNewPostView: Bool = false
    @Published var isShowNewStoryView: Bool = false
    @Published var isShowOptionForNavigateStoryView: Bool = false
    
    @Published var tabBar: UITabBar! = nil
}
