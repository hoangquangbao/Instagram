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
    let onImageTap: (() -> Void)?
    
    private let _spacing = 2.0
    private var _gridColumns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    init(images: [ImageItem], columnCount: Int? = 3, onImageTap: (() -> Void)? = nil) {
        self.images = images
        self.columnCount = columnCount!
        self.onImageTap = onImageTap
        initializeGridColumn(columnCount!)
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: _gridColumns, spacing: _spacing) {
                ForEach(images) { item in
                    NavigationLink {
                        ExploreView(image: item)
                    } label: {
                        _imageItem(with: item, size: _imageSize)
                    }
                }
            }
        }
    }
}

private extension ImageGridLayout {
    var _imageSize: CGFloat {
        return UIScreen.screenWidth / CGFloat(self.columnCount)
    }

    func _imageItem(with image: ImageItem, size: CGFloat) -> some View {
        return image.image
            .resizable()
            .frame(width: size, height: size)
            .contextMenu {
                Button {
                    StorageService.download()
                } label: {
                    HStack {
                        Text("Save")
                        Spacer()
                        Image(systemName: "arrow.down.to.line")
                    }
                }

            }
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
