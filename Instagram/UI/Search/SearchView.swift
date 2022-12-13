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
    @EnvironmentObject var userVm: UserViewModel
    @EnvironmentObject var postVm: PostViewModel
    
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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

// Components
private extension SearchView {
    var _searchBar: some View {
        SearchBar(searchText: $vm.searchText) {
            print("On change")
        }
        .focused($_searchIsFocused)
        .onTapGesture {
            vm.switchMode(.searching)
        }
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
    
    var _imageGridAndFilteredBar: some View {
        Group {
//            _filteredBar
            
            ScrollView {
                if postVm.isFetching {
                    ImageGridShimmer()
                } else {
                    PostImageGridLayout(posts: postVm.getNotOwningPost()).padding(.top, 5)
                }
                
            }
            
            Spacer()
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
    
    var _usersRow: some View {
        ScrollView {
            LazyVStack {
                ForEach(userVm.searchableUser(vm.searchText)) { user in
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        UserRow(user: user).padding(.vertical, 5)
                    }
                }
            }
            .padding(AppStyle.defaultSpacing)
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

