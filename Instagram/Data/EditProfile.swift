import SwiftUI

struct EditProfile: Identifiable {
    let id = UUID()
    let title: String
}

var editProfileData: [EditProfile] = [
    EditProfile(title: "Name"),
    EditProfile(title: "Username"),
    EditProfile(title: "Bio")
]

