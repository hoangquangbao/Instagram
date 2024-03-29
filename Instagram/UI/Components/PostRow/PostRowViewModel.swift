//
//  PostRowViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//
import SwiftUI
import Firebase

@MainActor
class PostRowViewModel: ObservableObject {
    @Published var post: Post
    @Published var isNavigateProfileView: Int? = nil
    @Published var isNavigateCommentView: Int? = nil
    @Published var commentText: String = ""
    @Published var mentionUserText: String = ""
    @Published var waitingDialogTitle: String = "Uploading..."
    @Published var isShowEditPost: Bool = false
    @Published var isShowWaitingDialog: Bool = false
    @Published var isShowDeletePostAlert: Bool = false
    @Published var commentState: CommentState = .comment
    enum CommentState: String { case comment, mention }
    
    init(post: Post) {
        self.post = post
    }
    
    var imageSelectionIndex = 0
    var imageCount  : Int   { return post.imagesUrl.count }
    var likeCount   : Int   { return post.likeCount }
    var commentCount: Int   { return post.commentCount }
    var didLike: Bool {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return false }
        return post.likes.contains(uid)
    }
    
    func toggleNavigateProfileView() {
        self.isNavigateProfileView = 1
    }
    
    func toggleNavigateCommentView() {
        self.isNavigateCommentView = 1
    }
    
    func showAllComment() {
        print("All comment have been displayed")
    }
    
    func onFavorite() {
        print("favorite")
    }
    
    func onMessage() {
        print("message")
    }
    
    func onShare() {
        print("share")
    }
    
    func handleLikePost() async {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        if post.likes.contains(uid) {
            post.likes = post.likes.filter { $0 != uid }
            await _updateLikePost(with: postId, likes: post.likes)
            
        } else {
            post.likes.append(uid)
            await _updateLikePost(with: postId, likes: post.likes)
            if post.uid != uid {
                print("POST UID: \(post.uid)")
                print("CURRENT UID: \(uid)")
                _notifyToAuthor(of: post, action: .like)
            }
        }
    }
    
    func _updateLikePost(with id: String, likes: [String]) async {
        PostService.update(with: id, field: "likes", data: likes) { [self] isSuccess, error in
            if error != nil { return }
            
            Task {
                guard let _posts = try await PostService.get(by: id) else { return }
                self.post = _posts
                
                await getLatestUserLikePost()
            }
        }
    }
    
    func getLatestUserLikePost() async {
        if post.likeCount <= 0 { return }
        do {
            let latestUid = post.likes[post.likeCount - 1]
            self.post.latestUserLikePost = try await UserService.get(by: latestUid)
        }
        catch {
            
        }
    }
    
    func createComment() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        let comment = Comment(uid: uid, comment: commentText)
        
        PostService.update(with: postId, comment: comment) { [self] isSuccess, error in
            if error != nil { return }
            
            if post.uid != uid {
                _notifyToAuthor(of: post, action: .comment)
            }
            
            _increaseCommentCount(with: postId) {
                Task {
                    await self.loadComment()
                }
            }
        }
    }
    
    private func _notifyToAuthor(of post: Post, action: NotificationAction) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let content = action == NotificationAction.comment ? "has commented on your post" : "has liked your post"
        
        let notification = Notification(uid: post.uid, action: action, type: .post, referenceId: post.id!, userInteractionId: uid, content: content)
        
        if action == .like {
            NotificationService.createIfExist(notification) { isSuccess, _ in
                print("Like is \(isSuccess ? "success" : "fail")")
            }
            return
        }
        
        NotificationService.create(notification) { isSuccess, _ in
            print("\(action.rawValue) is \(isSuccess ? "success" : "fail")")
        }
        
    }
    
    func notifyToMentionUsers(of post: Post, users: [User]) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let mentionUsers: [User] = UserHelper.getAllMentionUser(from: commentText, with: users)
        
        mentionUsers.forEach { user in
            guard let notificationUid = user.id else { return }
            let content = "has mentioned you in a comment"
            
            let notification = Notification(uid: notificationUid, action: .mention, type: .post, referenceId: post.id!, userInteractionId: uid, content: content)
            
            NotificationService.create(notification) { isSuccess, _ in
                print(isSuccess)
            }
        }
    }
    
    private func _increaseCommentCount(with postId: String, completion: @escaping () -> Void) {
        let data = FieldValue.increment(1.0)
        PostService.update( with: postId, field: "commentCount", data: data) { isSuccess, _ in
            if !isSuccess { return }
            
            completion()
        }
    }
    
    func loadComment() async {
        guard let postId = post.id else { return }
        
        do {
            self.post.comments = try await PostService.getComments(with: postId)
        } catch {
            
        }
    }
    
    func handleEditPost(_caption: String, _imagesUrl: [String], completion: @escaping (Bool, Error?) -> Void) {
        guard let postId = post.id else { return }
        
        if _imagesUrl.count != imageCount {
            updatePost(with: postId, field: "imagesUrl", data: _imagesUrl) { isSuccess, error in
                if !isSuccess {
                    completion(false, error)
                    return
                }
            }
        }
        
        if _caption != post.caption {
            updatePost(with: postId, field: "caption", data: _caption) { isSuccess, error in
                if !isSuccess {
                    completion(false, error)
                    return
                }
            }
        }
        completion(true, nil)
    }
    
    func updatePost(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        
        PostService.update(with: id, field: field, data: data) { isSuccess, error in
            completion(isSuccess, error)
        }
    }
    
    func deletePost(completion: @escaping (Bool, Error?) -> Void) {
        guard let id = post.id else {
            return
        }
        
        if post.comments != nil {
            PostService.deleteComment(with: id, comments: post.comments!) { isSuccess, error in
                if !isSuccess {
                    completion(isSuccess, error)
                    return
                }
            }
        }
        
        PostService.delete(with: id) { isSuccess, error in
            completion(isSuccess, error)
        }
    }
    
    func downloadImage(fromUrl url: String, completion: @escaping(Bool) -> Void) {
        waitingDialogTitle = "Downloading..."
        isShowWaitingDialog.toggle()
        
        StorageService.download(with: url) { (isSuccess, error) in
            if error != nil {
                withAnimation {
                    self.isShowWaitingDialog.toggle()
                }
                completion(false)
                return
            }
            
            withAnimation {
                self.isShowWaitingDialog.toggle()
            }
            completion(true)
        }
    }
    
    func switchState(to state: CommentState) {
        commentState = state
    }
    
    func onCommentTextChange(_ text: String) {
        if text.last == nil {
            switchState(to: .comment)
            return
        }
        
        if (text.last == " " && commentState == .mention) {
            switchState(to: .comment)
            return
        }
        
        if text.last == "@" {
            switchState(to: .mention)
            mentionUserText = ""
            return
        }
        
        if commentState == .mention {
            mentionUserText = UserHelper.getLastMentionUsername(from: commentText)
        } else {
            mentionUserText = ""
        }
    }
    
    func selectMentionUser(_ user: User) {
        commentText = UserHelper.replaceLatestMentionUser(from: commentText, by: user.username) + " "
        mentionUserText = ""
        switchState(to: .comment)
    }
}
