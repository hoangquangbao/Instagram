import SwiftUI

struct EditProfile: Identifiable {
    let id = UUID()
    let title: String
}

var EditProfileData: [EditProfile] = [
    EditProfile(title: "Name"),
    EditProfile(title: "Username"),
    EditProfile(title: "Bio")
]

