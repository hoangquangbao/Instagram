//
//  SettingListData.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import Foundation
import SwiftUI

struct StaticListDataModel: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
}

var SettingListData: [StaticListDataModel] = [
    StaticListDataModel(image: Image.icnSetting, title: "Settings"),
    StaticListDataModel(image: Image.icnArchive, title: "Archive"),
    StaticListDataModel(image: Image.icnScan, title: "QR Code"),
    StaticListDataModel(image: Image.icnSaved, title: "Saved"),
    StaticListDataModel(image: Image.icnCloseFriend, title: "Close Friends"),
]
