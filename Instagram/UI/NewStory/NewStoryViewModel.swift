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
    @Published var isImagePickerDisplay: Bool = false
    @Published var captionColorHexSelected: String = "#FFFFFF"
    
    let templates: [String] = ["story_bg1", "story_bg2", "story_bg3", "story_bg4"]
//    let colors: [Color] = [Color.white, Color.black, Color(.systemRed)]
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
    
    func clearImageAttach() {
        withAnimation {
            self.templateSelected = nil
            self.imageAttach = nil
        }
    }
}
