//
//  ImageGridLayout.swift
//  Instagram
//
//  Created by lhduc on 07/10/2022.
//

import SwiftUI

struct ImageGridLayout: View {
    var images: [ImageItem]
    
    private let threeColumns: [GridItem] = [GridItem(.flexible()),
                                            GridItem(.flexible()),
                                            GridItem(.flexible())]
    private let spacing = 2.0
    
    var body: some View {
        VStack(spacing: self.spacing) {
            if(images.count <= 2) {
                _fullScreenMode
            }
            
            else {
                HStack(spacing: self.spacing) {
                    VStack(spacing: self.spacing) {
                        _imageItem(with: images[0].image, size: UIScreen.screenWidth / 3)
                        _imageItem(with: images[2].image, size: UIScreen.screenWidth / 3)
                    }
                    _imageItem(with: images[1].image, size: UIScreen.screenWidth / 1.5)
                }
                _renderGrid(for: subImages, with: threeColumns)
            }
        }
    }
    
    var subImages: [ImageItem] {
        var subImages = images
        subImages.removeSubrange(0...2)
        return subImages
    }
}

private extension ImageGridLayout {
    func _imageItem(with image: Image, size: CGFloat) -> some View {
        return image
            .resizable()
            .frame(width: size, height: size)
    }
    
    func _renderGrid(for images: [ImageItem], with columns: [GridItem]) -> some View {
        return LazyVGrid(columns: threeColumns, spacing: self.spacing) {
            ForEach(images) { item in
                _imageItem(with: item.image, size: UIScreen.screenWidth / 3)
            }
        }
    }
    
    var _fullScreenMode: some View {
        return VStack(spacing: self.spacing) {
            ForEach(images) { item in
                _imageItem(with: item.image, size: UIScreen.screenWidth)
            }
        }
    }
}

struct ImageGridLayout_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridLayout(images: imagesData)
    }
}
