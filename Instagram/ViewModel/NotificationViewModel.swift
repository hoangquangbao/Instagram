//
//  NotificationViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    @Published var unReadCount: Int = 0
    @Published var isFetching: Bool = false
    
    init() {
        Task {
            await getUnReadCount()
        }
    }
    
    @MainActor func getUnReadCount() async {
        let unReadCount = try? await NotificationService.getUnReadCount()
        self.unReadCount = unReadCount ?? 0
    }
    
    @MainActor func getAll() async {
        self.isFetching = true
        do {
            self.notifications = try await NotificationService.getAll()
            self.isFetching = false
        } catch {
            print(error)
            self.isFetching = false
        }
    }
    
    func create() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let notification = Notification(uid: uid, action: .like, type: .post, referenceId: "LeHuynhDucID", userInteractionId: "XTzUZUn51MWFEShk3R3nIoe5R4s2", content: "lhduc2205 has liked your post")
        
        NotificationService.create(notification) { isSuccess, _ in
            print(isSuccess)
        }
    }
}
