//
//  ProfilePostModel.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import Foundation

struct ProfilePost: Identifiable {
    let id = UUID()
    let image: String
    let type: String
}

var profilePostData: [ProfilePost] = [
    ProfilePost(image: "img_post_1", type: "multiple"),
    ProfilePost(image: "img_post_2", type: "video"),
    ProfilePost(image: "img_post_3", type: "multiple"),
    ProfilePost(image: "img_post_4", type: "video"),
    ProfilePost(image: "img_post_5", type: "multiple"),
    ProfilePost(image: "img_post_6", type: "video"),
    ProfilePost(image: "img_post_7", type: "multiple"),
    ProfilePost(image: "img_post_8", type: "video"),
    ProfilePost(image: "img_post_9", type: "multiple")
]
