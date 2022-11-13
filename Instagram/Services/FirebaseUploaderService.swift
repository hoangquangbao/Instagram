//
//  ImageUploaderService.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import SwiftUI

struct FirebaseUploaderService {
        
    static func uploadImage(
        _ image: UIImage,
        _ purpose: ImageFor,
        withPath path: String,
        completion: @escaping (String?, Error?) -> Void
    ) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        var fileName: String = ""
        if purpose == .for_post {
            fileName = NSUUID().uuidString
        } else {
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
            fileName = uid
        }

        let ref = FirebaseManager.shared.storage.reference(withPath: path + "/" + fileName)
        
        ref.putData(imageData) { _, err in
            if err != nil { completion(nil, err); return }

            ref.downloadURL { url, _ in
                guard let url = url?.absoluteString else { return }
                completion(url, nil)
            }
        }
    }
}
