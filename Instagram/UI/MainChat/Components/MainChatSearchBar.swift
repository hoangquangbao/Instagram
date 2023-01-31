//
//  MainChatSearchBar.swift
//  Instagram
//
//  Created by lhduc on 16/01/2023.
//

import SwiftUI

struct MainChatSearchBar: View {
    @EnvironmentObject var vm: MainChatViewModel
    
    @FocusState private var _isSearchFocus: Bool
    
    var body: some View {
        HStack {
            _searchBar
            
            if vm.mode == .searching {
                _cancelButton
            }
        }
    }
}

private extension MainChatSearchBar {
    var _searchBar: some View {
        SearchBar(searchText: $vm.searchText) {
            
        }
        .focused($_isSearchFocus)
        .onTapGesture { vm.switchMode(.searching) }
    }
    
    var _cancelButton: some View {
        Button {
            vm.switchMode(.normal)
            vm.searchText = ""
            _isSearchFocus = false
        } label: {
            Text("Cancel")
        }
    }
}

struct MainChatSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        MainChatSearchBar()
    }
}
