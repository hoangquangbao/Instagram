//
//  ImageGridLayout.swift
//  Instagram
//
//  Created by lhduc on 07/10/2022.
//

import SwiftUI
import Kingfisher

struct PostImageGridLayout: View {
    let posts: [Post]
    let columnCount: Int
    let onImageTap: (() -> Void)?
    
    private let _spacing = 2.0
    private var _gridColumns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    init(posts: [Post], columnCount: Int = 3, onImageTap: (() -> Void)? = nil) {
        self.posts = posts
        self.columnCount = columnCount
        self.onImageTap = onImageTap
        initializeGridColumn(columnCount)
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: _gridColumns, spacing: _spacing) {
                ForEach(posts) { post in
                    NavigationLink {
                        ExploreView(post: post)
                    } label: {
                        _squareImage(with: post.imagesUrl[0], size: _imageSize)
                    }
                }
            }
        }
    }
}

private extension PostImageGridLayout {
    var _imageSize: CGFloat {
        return UIScreen.screenWidth / CGFloat(self.columnCount)
    }

    func _squareImage(with imageUrl: String, size: CGFloat) -> some View {
        return KFImage(URL(string: imageUrl))
            .resizable()
            .frame(width: size, height: size)
            .transition(.opacity)
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

struct PostImageGridLayout_Previews: PreviewProvider {
    static var previews: some View {
        PostImageGridLayout(posts: MockData.posts)
    }
}
