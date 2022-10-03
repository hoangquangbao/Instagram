//
//  SettingListData.swift
//  Instagram
//
//  Created by Tran Thuan on 27/09/2022.
//

import Foundation

struct StaticListDataModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
}

var SettingListData: [StaticListDataModel] = [
    StaticListDataModel(image: "setting2", title: "Setting"),
    StaticListDataModel(image: "Activity", title: "Archive"),
    StaticListDataModel(image: "insights", title: "Insight"),
    StaticListDataModel(image: "qr", title: "QR Code"),
    StaticListDataModel(image: "save", title: "Saved"),
    StaticListDataModel(image: "closefriend", title: "Close Friends"),
    StaticListDataModel(image: "discover", title: "Discover People"),
]
