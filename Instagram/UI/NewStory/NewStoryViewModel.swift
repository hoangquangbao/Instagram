//
//  NewStoryViewModel.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import SwiftUI

class NewStoryViewModel: ObservableObject {
    @Published var caption: String = ""
    @Published var imageAttach: UIImage?
    @Published var templateSelected: String?
    @Published var isTextCenter: Bool = false
    @Published var isStoryUploading: Bool = false
    @Published var isErrorAlertDisplay: Bool = false
    @Published var isImagePickerDisplay: Bool = false
    @Published var captionColorHexSelected: String = "#FFFFFF"
    
    let templates: [String] = ["story_bg1", "story_bg2", "story_bg3", "story_bg4"]
    let colors: [String] = ["#FFFFFF", "#000000", "#3897F0", "#FF6464", "#4649FF"]
    
    func selectTemplate(for name: String){
        withAnimation(.linear(duration: 0.2)) {
            if(templateSelected == nil || templateSelected != name) {
                self.templateSelected = name
                self.imageAttach = UIImage(named: name)
                return
            }
            
            templateSelected = nil
        }
    }
    
    func uploadStory(completion: @escaping (Bool) -> Void) {
        self.isStoryUploading.toggle()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let imageAttach = imageAttach else { return }
        
        print("Upload image...")
        FirebaseUploaderService.uploadImage(
            imageAttach,
            withPath: FirebaseConstants.STORY_PATH
        ) { [self] imageUrl, error in
            
            if error != nil { completion(false); return }
            guard let imageUrl = imageUrl else { completion(false); return }
            
            let story = Story(uid: uid,
                              caption: self.caption,
                              imagesUrl: imageUrl,
                              captionColorHex: self.captionColorHexSelected,
                              textAlignment: self.isTextCenter ? "center" : "bottom")
            
            _createStory(story) { [self] isSuccess in
                if !isSuccess { return }
                
                UserService.update(with: uid, field: "hasStory", data: true) { isSuccess, _ in
                    completion(isSuccess)
                    return
                }
            }
        }
    }
    
    func _createStory(_ story: Story, completion: @escaping (Bool) -> Void) {
        print("Upload story...")
        StoryService.create(story) { (isSuccess, _) in
            if(!isSuccess) {
                completion(false)
            }
            
            completion(true)
        }
    }
    
    func clearImageAttach() {
        withAnimation {
            self.templateSelected = nil
            self.imageAttach = nil
        }
    }
}
