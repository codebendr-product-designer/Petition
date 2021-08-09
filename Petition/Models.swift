//
//  Models.swift
//  Models
//
//  Created by Evans Domina Attafuah on 07/08/2021.
//

import Foundation
import SwiftUI

struct Petition: Codable, Identifiable {
    let id, title, body: String
    var emoji: String {
        ["🔐","🧘🏿‍♂️","🧨","💡","🚁","🎯","🎨", "🛺", "🚦"].randomElement()!
    }
    let signatureCount, signatureThreshold: Int
}


