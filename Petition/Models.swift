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
        ["๐","๐ง๐ฟโโ๏ธ","๐งจ","๐ก","๐","๐ฏ","๐จ", "๐บ", "๐ฆ"].randomElement()!
    }
    let signatureCount, signatureThreshold: Int
}


