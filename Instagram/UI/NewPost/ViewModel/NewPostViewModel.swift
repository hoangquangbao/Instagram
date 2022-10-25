//
//  AddPostViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

class NewPostViewModel: ObservableObject {
    var user: User
    
    @Published var caption: String = ""
    
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
