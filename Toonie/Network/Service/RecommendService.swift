//
//  RecommendService.swift
//  Toonie
//
//  Created by 양어진 on 20/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct RecommendService: Requestable {
    typealias NetworkData = Recommends
    static let shared = RecommendService()
    
    func getRecommends(completion: @escaping ([String]) -> Void) {
        get(API.tags + "/curationtags") { result in
            switch result {
            case .networkSuccess(let data):
                guard let curationTagList = data.resResult.curationTagList else { return }
                completion(curationTagList)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Recommend Network Fail")
            }
        }
    }
    
}
