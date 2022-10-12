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
    
    var filteredItems = SearchData.filteredItemsData
    var images: [ImageItem] = SearchData.imagesData
    
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
                SearchData.imagesData.forEach({ imageItem in
                    if(imageItem.category == category) {
                        filterImages.append(imageItem)
                    }
                })
            }
        }
        
        images = falseSize == itemsSelectionState.count ? SearchData.imagesData : filterImages
    }
    
    func binding(for key: String) -> Binding<Bool> {
        return Binding(get: {
            return self.itemsSelectionState[key] ?? false
        }, set: {
            self.itemsSelectionState[key] = $0
        })
    }
}
