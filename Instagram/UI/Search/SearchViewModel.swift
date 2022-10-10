//
//  SearchViewModel.swift
//  Instagram
//
//  Created by lhduc on 05/10/2022.
//
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var itemsSelectionState = [String: Bool]()
    
    init() {
        initializeFilterSelectionState()
    }
    
    var filteredItems = filteredItemsData
    var images: [ImageItem] = imagesData
    
    func initializeFilterSelectionState() {
        self.filteredItems.forEach { item in
            itemsSelectionState[item.title] = false
        }
    }
    
    func toggle(for category: String){
        itemsSelectionState[category] = !itemsSelectionState[category]!
        refreshImages()
    }
    
    func refreshImages() {
        var falseSize: Int = 0
        var filterImages: [ImageItem] = []
        itemsSelectionState.forEach { (category: String, isSelected: Bool) in
            if(!isSelected) {
                falseSize += 1
            }
            else {
                imagesData.forEach({ imageItem in
                    if(imageItem.category == category) {
                        filterImages.append(imageItem)
                    }
                })
            }
        }
        
        images = falseSize == itemsSelectionState.count ? imagesData : filterImages
    }
    
    func binding(for key: String) -> Binding<Bool> {
        return Binding(get: {
            return self.itemsSelectionState[key] ?? false
        }, set: {
            self.itemsSelectionState[key] = $0
        })
    }
    
}

var filteredItemsData: [SearchFilterItem] = [
    SearchFilterItem(title: "IGTV", image: Image.icnTv),
    SearchFilterItem(title: "Shop", image: Image.icnShop),
    SearchFilterItem(title: "Style"),
    SearchFilterItem(title: "Sports"),
    SearchFilterItem(title: "Auto"),
]

var imagesData: [ImageItem] = [
    ImageItem(image: Image.imgProfile, category: filteredItemsData[0].title),
    ImageItem(image: Image.imgProfile2, category: filteredItemsData[1].title),
    ImageItem(image: Image.imgProfile3, category: filteredItemsData[2].title),
    ImageItem(image: Image.imgProfile4, category: filteredItemsData[3].title),
    ImageItem(image: Image.imgProfile5, category: filteredItemsData[1].title),
    ImageItem(image: Image.imgProfile6, category: filteredItemsData[1].title),
    ImageItem(image: Image.imgProfile7, category: filteredItemsData[1].title),
]

struct SearchFilterItem: Identifiable {
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
