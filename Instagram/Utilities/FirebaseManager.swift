import SwiftUI
import Firebase
import FirebaseStorage

class FirebaseManager: NSObject {
    let auth : Auth
    let storage : Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        
        FirebaseApp.configure()
        
        auth = Auth.auth()
        storage = Storage.storage()
        
        super.init()
    }
}
