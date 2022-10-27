//
//  AddPostViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

class NewPostViewModel: ObservableObject {
    var user: User
    var actionType:  ActionType   =  .image
    
    @Published var caption: String = ""
    @Published var isBottomSheetDisplayed: Bool = false
    
    enum ActionType: String { case image, camera, emoji, more }
    
    init(user: User) {
        self.user = user
    }
    
    func resetCaption() {
        self.caption = ""
    }
    
    func uiImageToImage(_ images: [UIImage]) -> [Image] {
        var result = [Image]()
        images.forEach { image in
            result.append(Image(uiImage: image))
        }
        
        return result
    }
    
}
