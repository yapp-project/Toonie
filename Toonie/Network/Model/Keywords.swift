//
//  File.swift
//  Toonie
//
//  Created by 박은비 on 31/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation
struct Keywords: Codable {
    let success: Bool?
    let keywords: [String]?
}

struct MyKeywords: Codable {
    let success: Bool?
    let token: String?
    let myKeywords: [String]?
}
