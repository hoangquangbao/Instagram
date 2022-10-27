//
//  String+Utilities.swift
//  Instagram
//
//  Created by lhduc on 06/10/2022.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

extension Int {
    func toString() -> String{
        return String(self)
    }
}
