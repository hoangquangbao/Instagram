//
//  File.swift
//  Instagram
//
//  Created by lhduc on 10/11/2022.
//

import Foundation
class CommentViewModel: ObservableObject {
    @Published var isShowWaitingDialog: Bool = false
    
    private let postService = PostService()
}
