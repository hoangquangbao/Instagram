//
//  ImageGridLayout.swift
//  Instagram
//
//  Created by lhduc on 07/10/2022.
//

import SwiftUI

struct ImageGridLayout: View {
    let images: [ImageItem]
    let columnCount: Int
    
    private let _spacing = 2.0
    private var _gridColumns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    init(images: [ImageItem], columnCount: Int? = 3) {
        self.images = images
        self.columnCount = columnCount!
        initializeGridColumn(columnCount!)
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: _gridColumns, spacing: _spacing) {
                ForEach(images) { item in
                    _imageItem(with: item.image, size: UIScreen.screenWidth / CGFloat(columnCount))
                }
            }
        }
    }
}

private extension ImageGridLayout {
    func _imageItem(with image: Image, size: CGFloat) -> some View {
        return image
            .resizable()
            .frame(width: size, height: size)
    }
    
    mutating func initializeGridColumn(_ column: Int) {
        _gridColumns = Array(repeating: GridItem(.flexible()), count: column)
    }
}

struct ImageGridLayout_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridLayout(images: SearchData.imagesData)
    }
}
