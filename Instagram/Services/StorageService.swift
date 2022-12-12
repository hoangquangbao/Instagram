//
//  StorageService.swift
//  Instagram
//
//  Created by lhduc on 12/10/2022.
//

import SwiftUI

struct StorageService {
    static func download(with url: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            do {

                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    print("Downloading to photo album...")
                    
                    let imageSaver = ImageSaver(
                        successHandler: {
                            completion(true, nil)
                        },
                        errorHandler: { error in
                            completion(false, error)
                        }
                    )
                    
                    imageSaver.writeToPhotoAlbum(image: UIImage(data: data)!)
                }
            } catch {
                print("[ERROR] from `Download` with detail: \(error.localizedDescription)")
                completion(false, error)
            }
        }
    }
}
