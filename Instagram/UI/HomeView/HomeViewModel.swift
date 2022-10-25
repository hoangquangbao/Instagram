//
//  HomeViewModel.swift
//  Instagram
//
//  Created by lhduc on 15/10/2022.
//

import Foundation
class HomeViewModel: ObservableObject {
    var users = MockData.users.filter { user in
        user.hasStory == true
    }
    
    func navigateMessageView() {
        print("navigate to Message View")
    }
}
