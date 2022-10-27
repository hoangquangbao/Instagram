//
//  AddPostViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

class NewPostViewModel: ObservableObject {
    var user: User
    
    @Published  var caption: String = ""
    @Published  var isBottomSheetDisplayed: Bool = false
    
    init(user: User) {
        self.user = user
    }
    
    func resetCaption() {
        caption = ""
    }
    
    func uiImageToImage(_ uiImages: [UIImage]) -> [Image] {
        var result = [Image]()
        uiImages.forEach { image in
            result.append(Image(uiImage: image))
        }
        
        return result
    }
    
}
