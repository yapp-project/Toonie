//
//  Toon ieUpdateChkService.swift
//  Toonie
//
//  Created by 박은비 on 10/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

struct ToonieUpdateChkService: Requestable {
    typealias NetworkData = ToonieUpdateChk
    static let shared = ToonieUpdateChkService()
    
    func getUpdateInfo(completion : @escaping (ToonieUpdateChk) -> Void) {
        get(API.toonieUpdateChk) { result in
            switch result {
            case .networkSuccess(let data):
                completion(data.resResult)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Token Network Fail")
            }
        }
    }
}
