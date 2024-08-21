//
//  RecetaEntity.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 19/08/24.
//

import Foundation
import GRDB

struct RecetaEntity: Codable, FetchableRecord, PersistableRecord {
    var id: Int
    var title: String
    var image: String
}
