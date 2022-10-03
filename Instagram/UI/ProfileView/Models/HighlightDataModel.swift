//
//  HighlightDataModel.swift
//  Instagram
//
//  Created by Tran Thuan on 27/09/2022.
//

import Foundation

struct HighlightDataModel: Identifiable {
    let id = UUID()
    let name: String
    let cover: String
}

var HighlightData: [HighlightDataModel] = [
    HighlightDataModel(name: "Github", cover: "h-1"),
    HighlightDataModel(name: "Instagram", cover: "h-2"),
    HighlightDataModel(name: "Linkdin", cover: "h-3"),
    HighlightDataModel(name: "Youtube", cover: "h-4"),
    HighlightDataModel(name: "Facebook", cover: "h-5"),
    HighlightDataModel(name: "LeedCode", cover: "h-6"),
    HighlightDataModel(name: "StackOverflow", cover: "h-7")
]
