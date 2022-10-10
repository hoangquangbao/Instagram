//
//  SearchBar.swift
//  Instagram
//
//  Created by lhduc on 05/10/2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onChange: (() -> Void)?
    
    @State private var leadingIconColor = Color(.lightGray)
    @State private var isFocus = false
    
    var body: some View {
        TextField("Search", text: $searchText, onEditingChanged: {isEditing in
            self.onEditingChanged(isEditing)
        })
        .font(.sfProTextMedium(18, relativeTo: .caption2))
        .padding(.horizontal, 45)
        .padding(.vertical, 10)
        .background(Color(118, 118, 128, withOpacity: 0.12))
        .cornerRadius(10)
        .overlay {
            HStack {
                _searchIcon
                Spacer()
                if(searchText.isNotEmpty) {
                   _clearIcon
                }
            }
        }
        .onChange(of: searchText) { _ in
            (onChange ?? {})()
        }
    }
}

private extension SearchBar {
    var _searchIcon: some View {
        Image("icn_search")
            .renderingMode(.template)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(self.leadingIconColor)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 15)
    }
    
    var _clearIcon: some View {
        Button(action: resetSearchText) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 10)
        }
    }
    
    func onEditingChanged(_ isEditing: Bool) {
        self.isFocus = isEditing
        self.leadingIconColor = isEditing ? Color(.black) : Color(.lightGray)
    }
    
    func resetSearchText() {
        searchText = ""
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("asdas"))
    }
}
