//
//  SearchView.swift
//  Instagram
//
//  Created by lhduc on 05/10/2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = SearchViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    SearchBar(searchText: $vm.searchText) {
                        print("On change")
                    }
                    _cameraButton
                }
                .padding(.horizontal, AppStyle.defaultSpacing)
                
                _filteredBar
                
                ImageGridLayout(images: vm.images).padding(.top, 5)
                
                Spacer()
            }
        }
    }
}

private extension SearchView {
    var _cameraButton: some View {
        Button(action: _openCamera) {
            Image.icnCamera
                .renderingMode(.template)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color(.black))
                .padding(.leading, 10)
        }
    }
    
    func _openCamera() {
        print("open camera")
    }
    
    var _filteredBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.filteredItems) { item in
                    ChoiceChip(
                        titleKey: item.title,
                        image: item.image,
                        isSelected: vm.binding(for: item.title),
                        onSelected: { vm.toggle(for: item.title) }
                    )
                }
                
            }
        }
        .padding(.top, 5)
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}




