//
//  SearchItemModel.swift
//  Instagram
//
//  Created by lhduc on 10/10/2022.
//
import SwiftUI

struct SearchCategoryModel: Identifiable {
    let id = UUID()
    
    let title: String
    var leadingIcon: Image?
    var isSelected: Bool? = false
    var onSelected: ((String) -> Void)?
}
