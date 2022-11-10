//
//  PostServiceProtocol.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

import Foundation

protocol ServiceProtocol {
    associatedtype ModelType
    
    func get(by id: String, completion: @escaping (ModelType) -> Void)
    func getAll(completion: @escaping ([ModelType]) -> Void)
    func create(_: ModelType, completion: @escaping (Bool, Error?) -> Void)
    func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void)
    func delete(with id: String, completion: @escaping (Bool, Error?) -> Void)
}

