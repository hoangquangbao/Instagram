//
//  SearchData.swift
//  Instagram
//
//  Created by lhduc on 10/10/2022.
//

import SwiftUI

struct SearchData {
    static var categoriesFilteredData: [SearchCategoryModel] = [
        SearchCategoryModel(title: "IGTV", leadingIcon: Image.icnTv),
        SearchCategoryModel(title: "Shop", leadingIcon: Image.icnShop),
        SearchCategoryModel(title: "Style"),
        SearchCategoryModel(title: "Sport"),
    ]

//    static var imagesData: [ImageItem] = [
//        ImageItem(image: Image.imgProfile, category: filteredItemsData[0].title),
//        ImageItem(image: Image.imgProfile2, category: filteredItemsData[1].title),
//        ImageItem(image: Image.imgProfile3, category: filteredItemsData[2].title),
//        ImageItem(image: Image.imgProfile4, category: filteredItemsData[3].title),
//        ImageItem(image: Image.imgProfile5, category: filteredItemsData[1].title),
//        ImageItem(image: Image.imgProfile6, category: filteredItemsData[1].title),
//        ImageItem(image: Image.imgProfile7, category: filteredItemsData[1].title),
//    ]
}
