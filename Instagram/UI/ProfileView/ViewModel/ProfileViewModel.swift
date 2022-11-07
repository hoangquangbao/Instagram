//
//  ProfileViewModel.swift
//  Instagram
//
//  Created by Tran Thuan on 02/11/2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    var userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
}