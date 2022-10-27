//
//  PostRowViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//
import SwiftUI

class PostRowViewModel: ObservableObject {
    let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var imageSelectionIndex = 0
    var imageCount        : Int  { return post.imagesUrl.count }
    var latestUserLikePost: User? { return post.latestUserLiked }
    var likeCount         : Int  { return post.likeCount }
    var commentCount      : Int  { return post.commentCount }
    
    func imagesUrlToImageView() -> [Image] {
        var result = [Image]()
        post.imagesUrl.forEach { image in
            result.append(Image(image))
        }
        
        return result
    }
    
    func showAllComment() {
        print("All comment have been displayed")
    }
    
    func onFavorite() {
        print("favorite")
    }
    
    func onComment() {
        print("comment")
    }
    
    func onMessage() {
        print("message")
    }
    
    func onShare() {
        print("share")
    }
}
