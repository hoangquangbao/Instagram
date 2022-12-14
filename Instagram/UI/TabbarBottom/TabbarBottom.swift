//
//  TabbarBottomViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//
import SwiftUI

enum TabbarBottom: Int, CaseIterable {
    case home, search, favorite, notification, profile
    
    func getView(user: User) -> AnyView {
        switch self {
        case .home:         return AnyView(HomeView())
        case .search:       return AnyView(SearchView())
        case .favorite:     return AnyView(Text("Favorite view"))
        case .notification: return AnyView(NotificationView())
        case .profile:      return AnyView(ProfileView(user: user))
        }
    }
    
    func getImage(isActive: Bool = false) -> Image {
        switch self {
        case .home:         return isActive ? Image.icnHomeBold         : Image.icnHome
        case .search:       return isActive ? Image.icnSearchBold       : Image.icnSearch
        case .favorite:     return isActive ? Image.icnHeartBold        : Image.icnHeart
        case .notification: return isActive ? Image.icnNotificationBold : Image.icnNotification
        case .profile:      return isActive ? Image.icnUserBold         : Image.icnUser
        }
    }
}
