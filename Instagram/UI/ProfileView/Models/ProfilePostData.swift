//
//  ProfilePostData.swift
//  Instagram
//
//  Created by Tran Thuan on 27/09/2022.
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
    ProfilePostModel(image: "post_1", type: "multiple"),
    ProfilePostModel(image: "post_2", type: "video"),
    ProfilePostModel(image: "post_3", type: "multiple"),
    ProfilePostModel(image: "post_4", type: "video"),
    ProfilePostModel(image: "post_5", type: "multiple"),
    ProfilePostModel(image: "post_6", type: "video"),
    ProfilePostModel(image: "post_7", type: "multiple"),
    ProfilePostModel(image: "post_8", type: "video"),
    ProfilePostModel(image: "post_9", type: "multiple")
]
