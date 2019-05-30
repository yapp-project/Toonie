//
//  ReviewerService.swift
//  Toonie
//
//  Created by 양어진 on 30/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct ReviewerService: Requestable {
    typealias NetworkData = Reviewer
    static let shared = ReviewerService()
    
    /// 리뷰어 인지 아닌지 조회.
    func getIsReviewer(completion: @escaping (Bool?) -> Void) {
        get("http://eunbi6431.cafe24.com/Toonie/chkReview.json") { result in
            switch result {
            case .networkSuccess(let data):
                completion(data.resResult.inReview)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Reviewer Network Fail")
            }
        }
    }
    
}
