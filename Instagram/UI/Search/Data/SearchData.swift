//
//  SearchData.swift
//  Instagram
//
//  Created by lhduc on 10/10/2022.
//

import SwiftUI

struct SearchData {
    static var filteredItemsData: [FilteredSearchItem] = [
        FilteredSearchItem(title: "IGTV", image: Image.icnTv),
        FilteredSearchItem(title: "Shop", image: Image.icnShop),
        FilteredSearchItem(title: "Style"),
        FilteredSearchItem(title: "Sports"),
        FilteredSearchItem(title: "Auto"),
    ]

    static var imagesData: [ImageItem] = [
        ImageItem(image: Image.imgProfile, category: filteredItemsData[0].title),
        ImageItem(image: Image.imgProfile2, category: filteredItemsData[1].title),
        ImageItem(image: Image.imgProfile3, category: filteredItemsData[2].title),
        ImageItem(image: Image.imgProfile4, category: filteredItemsData[3].title),
        ImageItem(image: Image.imgProfile5, category: filteredItemsData[1].title),
        ImageItem(image: Image.imgProfile6, category: filteredItemsData[1].title),
        ImageItem(image: Image.imgProfile7, category: filteredItemsData[1].title),
    ]
}
