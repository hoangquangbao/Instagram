import Foundation
import SwiftUI

struct StaticList: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
}

var SettingListData: [StaticList] = [
    StaticList(image: Image.icnSetting, title: "Settings"),
    StaticList(image: Image.icnArchive, title: "Archive"),
    StaticList(image: Image.icnScan, title: "QR Code"),
    StaticList(image: Image.icnSaved, title: "Saved"),
    StaticList(image: Image.icnCloseFriend, title: "Close Friends"),
]
