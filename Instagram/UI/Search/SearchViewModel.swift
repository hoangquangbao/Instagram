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
    @Published var isSearchingMode = false
    
    enum Mode { case postSuggestion, searching }
    
    let users: [User] = MockData.users
    let filteredItems = SearchData.filteredItemsData
    var images: [ImageItem] = SearchData.imagesData
    var mode: Mode = .postSuggestion
    
    init() {
        initializeFilterSelectionState()
    }
    
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
        return Binding(
            get: { return self.itemsSelectionState[key] ?? false },
            set: { self.itemsSelectionState[key] = $0 }
        )
    }
    
    func openCamera() {
        print("open camera")
    }
    
    func switchMode(_ mode: Mode) {
        withAnimation(.easeInOut(duration: 0.3)) {
            self.mode = mode
        }
    }
    
    var searchableUser: [User] {
        if(searchText.isEmpty) { return users }
        
        return users.filter { user in
            user.username.contains(searchText) || user.fullname.contains(searchText)
        }
    }
}
