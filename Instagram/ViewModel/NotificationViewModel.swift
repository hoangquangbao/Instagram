//
//  NotificationViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import Firebase

@MainActor class NotificationViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    @Published var unReadCount: Int = 0
    @Published var isFetching: Bool = false
    
    init() {
        getUnReadCount()
        getAll()
    }
    
    func getUnReadCount() {
        NotificationService.getUnReadCount {[self] count in
            Task {
                unReadCount = count
            }
        }
    }
    
//    func getAll() async {
//        self.isFetching = true
//        do {
//            self.notifications = try await NotificationService.getAll()
//            self.isFetching = false
//        } catch {
//            print(error)
//            self.isFetching = false
//        }
//    }
    func getAll() {
        self.isFetching = true
        NotificationService.getAll { notifications in
            Task {
                print(notifications)
                self.notifications = notifications
                self.isFetching = false
            }
        }
    }
    
    func read(notification: Notification, completion: @escaping () -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        if notification.isRead {
            completion()
            return
        }
        
        NotificationService.update(with: notification.id, field: "isRead", data: true) { isSuccess, _ in
            if !isSuccess { return }
        
            NotificationService.updateUnReadCount(of: uid, data: FieldValue.increment(-1.0)) { isSuccess, _ in
                if !isSuccess { return }
                completion()
            }
        }
                
    }
}
