//
//  ForYouToonListService.swift
//  Toonie
//
//  Created by 이재은 on 07/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct ForYouToonListService: Requestable {
    typealias NetworkData = ForYouToonLists
    static let shared = ForYouToonListService()
    
    /// '당신을 위한 공감툰' 정보 조회
    func getForYouToonList(completion: @escaping ([ToonList]?) -> Void) {
        get(API.forYouToons) { result in
            switch result {
            case .networkSuccess(let data):
                guard let toonList = data.resResult.toonList else { return }
                completion(toonList)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("ForYouToonList Network Fail")
            }
        }
    }
    
}
