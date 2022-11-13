//
//  ProfileViewModel.swift
//  Instagram
//
//  Created by Tran Thuan on 02/11/2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var isShowBottomSheet = false
    @Published var isShowDetailOption = false
    @Published var isShowEditProfile = false
    @Published var title: String = ""
    @Published var imageAttach: UIImage?
    @Published var isStoryUploading: Bool = false
    
    func _uploadAvatar(completion: @escaping (Bool, Error?) -> Void) {
        self.isStoryUploading.toggle()
        guard let imageAttach = imageAttach else { return }
        print("Upload avatar image...")
        FirebaseUploaderService.uploadImage(imageAttach, .for_avatar, withPath: FirebaseConstants.PROFILE_AVATAR_PATH) { [self] imageUrl, error in
            guard let imageUrl = imageUrl else {
                completion(false, error)
                return
            }
            
            _updateProfile(field: "avatarUrl", data: imageUrl) { isSuccess, error in
                guard let error = error else {
                    completion(isSuccess, nil)
                    return
                }
                completion(isSuccess, error)
            }
        }
    }
    
    func _updateProfile(field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        print("Update profile...")
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        UserService.update(with: uid, field: field, data: data) { isSuccess, error in
            guard let error = error else {
                completion(isSuccess, nil)
                return
            }
            completion(isSuccess, error)
        }
    }
    
    func getFieldKeyPath(key: String?) -> KeyPath<User, String>? {
        guard let key = key else { return nil }
        let field: [_: KeyPath<User, _>] = [
            "Name" : \.fullName,
            "Username" : \.username,
            "Bio" : \.description
        ]
        return field[key]
    }
}
