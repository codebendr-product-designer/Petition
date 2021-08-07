//
//  Models.swift
//  Models
//
//  Created by Evans Domina Attafuah on 07/08/2021.
//

import Foundation
import SwiftUI

struct Petition: Codable, Identifiable {
    let id: String
    let title, body: String
}
