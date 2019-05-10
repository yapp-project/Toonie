//
//  ToonieUpdateChk.swift
//  Toonie
//
//  Created by 박은비 on 10/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

struct ToonieUpdateChk: Codable {
    let forcedUpdate: Bool?
    let forceInfo: ForceInfo?
    let targetUpdate: Bool?
    let targetInfo: TargetInfo?
}

struct ForceInfo: Codable {
    let forcedAlertMode: String?
    let forcedVersion: String?
    let forcedString: String?
    let forcedMoveUrl: String?
}

struct TargetInfo: Codable {
    let targetAlertMode: String?
    let targetVersion: String?
    let targetString: String?
    let targetMoveUrl: String?
}
