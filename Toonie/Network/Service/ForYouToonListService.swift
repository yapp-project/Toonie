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
    
    func getForYouToonList(completion: @escaping ([ToonList]?) -> Void) {
        get(API.tags+"/token/\(CommonUtility.userToken)") { result in
            switch result {
            case .networkSuccess(let data):
                guard let toonList = data.resResult.toonList else { return }
                completion(toonList)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("ToonList Network Fail")
            }
        }
    }
    
}
