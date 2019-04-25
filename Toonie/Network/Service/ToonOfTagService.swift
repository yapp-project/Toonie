//
//  ToonOfTagService.swift
//  Toonie
//
//  Created by 이재은 on 16/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct ToonOfTagService: Requestable {
    typealias NetworkData = ToonOfTag
    static let shared = ToonOfTagService()
    
    func getToonOfTag(completion: @escaping ([ToonInfoList]?) -> Void) {
        get(API.tags+"/고양이") { result in
            switch result {
            case .networkSuccess(let data):
                guard let toonOfTag = data.resResult.toonInfoList else { return }
                completion(toonOfTag)
                print(toonOfTag)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("ToonofTag Network Fail")
            }
        }
    }
    
}
