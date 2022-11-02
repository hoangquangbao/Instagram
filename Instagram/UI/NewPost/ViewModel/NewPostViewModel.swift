//
//  AddPostViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

class NewPostViewModel: ObservableObject {
    var user: User
    var postService = PostService()
    
    @Published var caption: String = ""
    @Published var imageAttach: UIImage?
    @Published var isErrorAlertDisplayed = false
    @Published var isUploading: Bool = false
    @Published var isBottomSheetDisplayed: Bool = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
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
    
    func uploadPost(completion: @escaping (Bool) -> Void) {
        self.isUploading.toggle()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let imageAttach = imageAttach else { return }
        
        print("Upload image...")
        FirebaseUploaderService.uploadImage(imageAttach) { imageUrl, error in
            if error != nil { completion(false); return }
            guard let imageUrl = imageUrl else { completion(false); return }
            let post = Post(uid: uid, caption: self.caption, imagesUrl: [imageUrl])
            
            self._createPost(post) { isSuccess in
                completion(isSuccess)
                return
            }
        }
    }
    
    func _createPost(_ post: Post, completion: @escaping (Bool) -> Void) {
        print("Create post...")
        postService.create(post) { (isSuccess, _) in
            if(!isSuccess) {
                completion(false)
            }

            completion(true)
        }
    }

}
