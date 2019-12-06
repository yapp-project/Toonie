//
//  LookToonOfTagService.swift
//  Toonie
//
//  Created by 양어진 on 01/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

struct LookToonOfTagService: Requestable {
    typealias NetworkData = ToonOfTag
    static let shared = LookToonOfTagService()
    
    /// 태그로 툰 정보 조회
    func getLookToonOfTag(toonTag: String,
                          completion: @escaping (ToonOfTag) -> Void) {
        get(API.tags + "/" + toonTag) { (result) in
            switch result {
            case .networkSuccess(let value):
                let toonOfTag = value.resResult
                completion(toonOfTag)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("ToonofTag Network Fail")
            }
        }
    }
    
}
