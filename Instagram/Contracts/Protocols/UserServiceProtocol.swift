//
//  UserServiceProtocol.swift
//  Instagram
//
//  Created by lhduc on 27/10/2022.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUser(with uid: String, completion: @escaping(User) -> Void)
    func fetchAll(completion: @escaping([User]) -> Void)
    func createUser(_ user: User, completion: @escaping(Bool) -> Void)
    func updateUser(_ user: User, completion: @escaping(Bool) -> Void)
    func deleteUser(with id: String, completion: @escaping(Bool) -> Void)
}
