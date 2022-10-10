//
//  ProfilePostModel.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import Foundation

struct ProfilePostModel: Identifiable {
    let id = UUID()
    let image: String
    let type: String
}

struct User: Identifiable {
    var id = UUID()
    let userName: String
    let userImage: String
}

var ProfilePostData: [ProfilePostModel] = [
    ProfilePostModel(image: "img_post_1", type: "multiple"),
    ProfilePostModel(image: "img_post_2", type: "video"),
    ProfilePostModel(image: "img_post_3", type: "multiple"),
    ProfilePostModel(image: "img_post_4", type: "video"),
    ProfilePostModel(image: "img_post_5", type: "multiple"),
    ProfilePostModel(image: "img_post_6", type: "video"),
    ProfilePostModel(image: "img_post_7", type: "multiple"),
    ProfilePostModel(image: "img_post_8", type: "video"),
    ProfilePostModel(image: "img_post_9", type: "multiple")
]
