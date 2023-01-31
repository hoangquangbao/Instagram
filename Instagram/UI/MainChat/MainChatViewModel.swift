//
//  MainChatViewModel.swift
//  Instagram
//
//  Created by lhduc on 06/01/2023.
//

import Foundation
import SwiftUI

class MainChatViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var mode: Mode = .normal
    @Published var searchText: String = ""
    
    enum Mode: String { case normal, searching }
    
    init() {
        fetchConversations()
    }
    
    func fetchConversations() {
        guard let currentUid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        ConversationService.shared.getAll(uid: currentUid) { conversations in
            self.conversations = conversations
        }
    }
    
    func getConversation(of currentUser: User, with participant: User) async -> Conversation {
        
        let conversationId = ConversationHelper.getId(currentUser.id!, participant.id!)
        
        let conversation = try? await ConversationService.shared.get(by: conversationId)
        
        guard let conversation = conversation else {
            return createConversation(participants: [currentUser, participant])
        }
        
        return conversation
    }
    
    func createConversation(participants: [User]) -> Conversation {
        let conversation = Conversation(participants: participants)
        return conversation
    }
    
    func getParticipant(of currentUser: User, in conversation: Conversation) -> User? {
        let participant = ConversationHelper.getParticipant(of: currentUser.id!, in: conversation)
        
        return participant
    }
    
    func switchMode(_ mode: Mode) {
        withAnimation {
            self.mode = mode
        }
    }
    
    func findConversation(of firstUser: User, with secondUser: User) -> Conversation {
        let conversationId = ConversationHelper.getId(firstUser.uid, secondUser.uid)
        let conversation = conversations.first(where: { $0.id == conversationId } )

        return conversation ?? Conversation(participants: [firstUser, secondUser])
    }
}
