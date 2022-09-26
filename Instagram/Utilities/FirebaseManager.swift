import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager: NSObject {
    let auth : Auth
    let storage : Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        
        FirebaseApp.configure()
        
        auth = Auth.auth()
        storage = Storage.storage()
        firestore = Firestore.firestore()
        
        super.init()
    }
}
