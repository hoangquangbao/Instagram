//
//  PostServiceProtocol.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

import Foundation

protocol PostServiceProtocol {
    func fetchPosts(for uid: String, completion: @escaping ([Post]) -> Void)
    func fetchAll(completion: @escaping ([Post]) -> Void)
    func uploadPost(_ post: Post, completion: @escaping (Bool) -> Void)
    func updatePost(_ post: Post, completion: @escaping (Bool) -> Void)
    func deletePost(with id: String, completion: @escaping (Bool) -> Void)
}

