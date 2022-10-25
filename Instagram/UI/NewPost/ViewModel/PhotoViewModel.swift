//
//  PhotoViewModel.swift
//  Instagram
//
//  Created by lhduc on 20/10/2022.
//
import SwiftUI
import Photos

class PhotoModel: ObservableObject {
    @Published var allPhotos = [UIImage]()
    @Published var errorString : String = ""

    init() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.errorString = ""
                self.getAllPhotos()
            case .denied, .restricted:
                self.errorString = "Photo access permission denied"
            case .notDetermined:
                self.errorString = "Photo access permission not determined"
            case .limited:
                self.errorString = "limited"
            @unknown default:
                self.errorString = "error"
            }
        }
    }

    fileprivate func getAllPhotos() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if results.count > 0 {
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 700, height: 700) //You can change size here
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        self.allPhotos.append(image)
                    } else {
                        print("error asset to image")
                    }
                }
            }
        } else {
            self.errorString = "No photos to display"
        }
    }
    
    func getOrderOf(photo: UIImage, in photos: [UIImage]) -> Int {
        let index = photos.firstIndex {$0 == photo}
        return index! + 1
    }
}
