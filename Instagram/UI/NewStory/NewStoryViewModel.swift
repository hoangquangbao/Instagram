//
//  NewStoryViewModel.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import SwiftUI

class NewStoryViewModel: ObservableObject {
    @Published var imageAttach: UIImage?
    @Published var templateSelected: String?
    
    let templates = ["story_bg1", "story_bg2", "story_bg3", "story_bg4"]
    
    func selectTemplate(for name: String){
        withAnimation(.linear(duration: 0.2)) {
            if(templateSelected == nil || templateSelected != name) {
                templateSelected = name
                return
            }
            
            templateSelected = nil
        }
    }
}
