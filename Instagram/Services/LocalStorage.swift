//
//  LocalStorage.swift
//  Instagram
//
//  Created by lhduc on 03/11/2022.
//

import FirebaseFirestore

struct LocalStorage {
    static func retrieve<ModelType>(forKey key: String, completion: @escaping (ModelType) -> Void) where ModelType: Decodable {
        if let data = UserDefaults.standard.dictionary(forKey: key) {
            if let decoded = try? Firestore.Decoder().decode(ModelType.self, from: data) {
                completion(decoded)
                return
            }
        }
    }
    
    static func store<ModelType>(with data: ModelType, forKey: String) where ModelType: Encodable {
        if let encoded = try? Firestore.Encoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: forKey)
        }
    }
    
    static func delete(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
