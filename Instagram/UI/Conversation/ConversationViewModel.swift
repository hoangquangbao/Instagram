//
//  ConversationViewModel.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import Foundation

class ConversationViewModel: ObservableObject {
    @Published var conversation: Conversation!
    @Published var currentUser: User!
    @Published var participant: User!
    @Published var messageText: String = ""
    @Published var isMessagesLoading: Bool = false
    @Published var messageIdToScroll: String?
    
    
    init(_ conversation: Conversation) {
        self.conversation = conversation
        
        let currentUser: User? = LocalStorage.retrieve(forKey: StorageKey.USER_INFO)
        guard let currentUser = currentUser  else {
            return
        }
        
        self.currentUser = currentUser
        self.participant = ConversationHelper.getParticipant(of: currentUser.uid, in: conversation)
        
    }
    
    @MainActor
    func loadConversation() async -> Conversation? {
        self.isMessagesLoading = true
        let conversationId = ConversationHelper.getId(currentUser.id!, participant.id!)
        
        let conversation = try? await ConversationService.shared.get(by: conversationId)
        
        guard let conversation = conversation else {
            self.isMessagesLoading = false
            return nil
        }
        
        self.isMessagesLoading = false
        return conversation
        
    }
    
    func getParticipant(of currentUser: User, in conversation: Conversation) -> User? {
        let participant = ConversationHelper.getParticipant(of: currentUser.id!, in: conversation)
        
        return participant
    }

    func sendMessage(by sender: User, to receiver: User) {
        guard let senderId = sender.id else { return }
        let messageText = self.messageText
        
        self.clearMessageText()
        
        let message = Message(senderId: senderId, text: messageText)
        if self.conversation == nil {
            self.conversation = createConversation(participants: [sender, receiver], message: message)
            
        }
        
        ConversationService.shared.sendMessage(message, in: conversation!) { success, _ in

        }
        
    }
    
    private func createConversation(participants: [User], message: Message) -> Conversation {
        let id = ConversationHelper.getId(participants[0].uid, participants[1].uid)
        
        let conversation = Conversation(id: id, participants: participants)
        ConversationService.shared.create(conversation) { _, _ in }
        return conversation
    }
    
    private func clearMessageText() {
        self.messageText = ""
    }
}
