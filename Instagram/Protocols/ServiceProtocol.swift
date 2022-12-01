//
//  PostServiceProtocol.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

import Foundation

protocol ServiceProtocol {
    associatedtype ModelType
    
    static func get(by id: String) async throws -> ModelType?
    static func getAll(completion: @escaping ([ModelType]) -> Void)
    static func create(_: ModelType, completion: @escaping (Bool, Error?) -> Void)
    static func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void)
    static func delete(with id: String, completion: @escaping (Bool, Error?) -> Void)
}

