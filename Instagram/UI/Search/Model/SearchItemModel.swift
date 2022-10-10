//
//  SearchItemModel.swift
//  Instagram
//
//  Created by lhduc on 10/10/2022.
//
import SwiftUI

struct FilteredSearchItem: Identifiable {
    let id = UUID()
    
    let title: String
    var image: Image?
    var isSelected: Bool? = false
    var onSelected: ((String) -> Void)?
}

struct ImageItem: Identifiable {
    let id = UUID()
    
    let image: Image
    let category: String
}
