//
//  TokenService.swift
//  Toonie
//
//  Created by 박은비 on 30/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct TokenService: Requestable {
    
    typealias NetworkData = Token
//    static let shareInstance = Service()
    
    func getToken(url: String,
                  params: [String: Any]? = nil,
                  completion: @escaping (NetworkResult<Any>)
        -> Void) {
        get(url, params: params) { (result) in

            switch result {
            case .networkSuccess(let successResult):
                completion(.networkSuccess((successResult.resResult)))
            case .networkError(let errResult):
                completion(.networkError((errResult.resCode, errResult.msg)))
            case .networkFail:
                completion(.networkFail)
            }
        }
    }
    
}

struct KeywordsService: Requestable {
    typealias NetworkData = Keywords
    func getKeywords(url: String,
                     params: [String: Any]? = nil,
                     completion: @escaping (NetworkResult<Keywords>)
        -> Void) {
        get(url, params: params) { (result) in
            switch result {
            case .networkSuccess(let successResult):
                completion(.networkSuccess((successResult.resResult)))
            case .networkError(let errResult):
                completion(.networkError((errResult.resCode, errResult.msg)))
            case .networkFail:
                completion(.networkFail)
            }
        }
    }
    
}
