//
//  HighlightDataModel.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import Foundation

struct Highlight: Identifiable {
    let id = UUID()
    let name: String
    let cover: String
}

var highlightData: [Highlight] = [
    Highlight(name: "new", cover: "icn_plus_hl"),
    Highlight(name: "Instagram", cover: "icn_Instagram"),
    Highlight(name: "Linkin", cover: "icn_linkin"),
    Highlight(name: "Youtube", cover: "icn_youtube"),
    Highlight(name: "Facebook_black", cover: "icn_facebook_black"),
    Highlight(name: "Leedcode", cover: "icn_leedcode"),
    Highlight(name: "StackOverflow", cover: "icn_stackOverflow")
]
