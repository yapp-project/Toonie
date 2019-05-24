//
//  Toon ieUpdateChkService.swift
//  Toonie
//
//  Created by 박은비 on 10/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

struct ChkToonieUpdateService: Requestable {
    typealias NetworkData = ChkToonieUpdate
    static let shared = ChkToonieUpdateService()
    
    func getUpdateInfo(completion : @escaping (ChkToonieUpdate) -> Void) {
        get(API.chkToonieUpdate) { result in
            switch result {
            case .networkSuccess(let data):
                completion(data.resResult)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("ToonieUpdateChkService Network Fail")
            }
        }
    }
}
