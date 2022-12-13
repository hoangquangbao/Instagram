//
//  LazyView.swift
//  Instagram
//
//  Created by lhduc on 13/12/2022.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping() -> Content ) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
