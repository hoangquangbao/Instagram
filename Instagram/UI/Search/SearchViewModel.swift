//
//  SearchViewModel.swift
//  Instagram
//
//  Created by lhduc on 05/10/2022.
//
import SwiftUI

class SearchViewModel: ObservableObject {
    enum Mode { case postSuggestion, searching }
    
    @Published var searchText: String = ""
    @Published var itemsSelectionState = [String: Bool]()
    @Published var isSearchingMode = false
    @Published var mode: Mode = .postSuggestion
    
    let users: [User] = MockData.users
    var posts: [Post] = MockData.posts
    let categoriesFiltered = SearchData.categoriesFilteredData
    
    init() {
        initializeFilteredSelectionState()
    }
    
    func initializeFilteredSelectionState() {
        self.categoriesFiltered.forEach { category in
            itemsSelectionState[category.title] = false
        }
    }
    
    func toggle(for category: String){
        withAnimation(.linear(duration: 0.2)) {
            itemsSelectionState[category] = !itemsSelectionState[category]!
            refreshImages()
        }
    }
    
    func refreshImages() {
        var falseSize: Int = 0
        var postsFiltered: [Post] = []
        itemsSelectionState.forEach { (category: String, isSelected: Bool) in
            if(!isSelected) { falseSize += 1 }
            else {
                MockData.posts.forEach({ post in
                    if(post.categories.contains(category) && _isNotContain(post: post, in: postsFiltered)) {
                        postsFiltered.append(post)
                    }
                })
            }
        }
        
        posts = falseSize == itemsSelectionState.count ? MockData.posts : postsFiltered
    }
    
    private func _isNotContain(post: Post, in posts: [Post]) -> Bool {
        return !posts.contains(where: { _post in post.id == _post.id})
    }
    
    /// Convert Bool value to Binding when passing key of dictionary [String: Bool]
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
    
}
