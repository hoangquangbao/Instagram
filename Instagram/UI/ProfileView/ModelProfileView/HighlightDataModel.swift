//
//  HighlightDataModel.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import Foundation

struct HighlightDataModel: Identifiable {
    let id = UUID()
    let name: String
    let cover: String
}

var HighlightData: [HighlightDataModel] = [
    HighlightDataModel(name: "new", cover: "icn_plus_hl"),
    HighlightDataModel(name: "Instagram", cover: "icn_Instagram"),
    HighlightDataModel(name: "Linkin", cover: "icn_linkin"),
    HighlightDataModel(name: "Youtube", cover: "icn_youtube"),
    HighlightDataModel(name: "Facebook_black", cover: "icn_facebook_black"),
    HighlightDataModel(name: "Leedcode", cover: "icn_leedcode"),
    HighlightDataModel(name: "StackOverflow", cover: "icn_stackOverflow")
]
