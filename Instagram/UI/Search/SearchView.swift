//
//  SearchView.swift
//  Instagram
//
//  Created by lhduc on 05/10/2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = SearchViewModel()
    
    @FocusState private var _searchIsFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack {
                    HStack {
                        _searchBar
                        
                        _actionButtonBuilder
                    }
                    .padding(.horizontal, AppStyle.defaultSpacing)
                    
                    _bodyBuilder
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

// Components
private extension SearchView {
    var _searchBar: some View {
        SearchBar(searchText: $vm.searchText) {
            print("On change")
        }
        .focused($_searchIsFocused)
        .onTapGesture { vm.switchMode(.searching) }
    }
    
    var _cancelButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                vm.switchMode(.postSuggestion)
                vm.searchText = ""
                _searchIsFocused = false
            }
        } label: {
            Text("Cancel").font(.system(size: 16))
        }
    }
    
    var _filteredBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.categoriesFiltered) { item in
                    ChoiceChip(
                        titleKey: item.title,
                        image: item.leadingIcon,
                        isSelected: vm.binding(for: item.title),
                        onSelected: { vm.toggle(for: item.title) }
                    )
                }
                
            }
        }
        .padding(.top, 5)
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var _imageGridAndFilteredBar: some View {
        Group {
            _filteredBar
            ScrollView {
                PostImageGridLayout(posts: vm.posts).padding(.top, 5)
            }
            
            Spacer()
        }
    }
    
    var _usersRow: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.searchableUser) { user in
                    UserRow(user: user).padding(.vertical, 5)
                }
            }
            .padding(AppStyle.defaultSpacing)
        }
    }
}

// ViewBuilder
private extension SearchView {
    @ViewBuilder
    var _actionButtonBuilder: some View {
        if (vm.mode == .searching) {
            _cancelButton
        }
    }
    
    @ViewBuilder
    var _bodyBuilder: some View {
        if (vm.mode == .searching) {
            Group {
                _usersRow
                Spacer()
            }
        } else {
            _imageGridAndFilteredBar
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

