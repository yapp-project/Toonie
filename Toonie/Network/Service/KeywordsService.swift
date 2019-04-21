//
//  KeywordsService.swift
//  Toonie
//
//  Created by 박은비 on 20/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class KeywordsService: Requestable {
    typealias NetworkData = Keywords
    static let shared = KeywordsService()
    
    //전체 키워드 리스트를 조회
    func getKeywords(completion: @escaping ([String]?) -> Void) {
        get(API.keywords) { result in
            switch result {
            case .networkSuccess(let data):
                if data.resResult.success == false {
                    return
                }
                completion(data.resResult.keywords)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("fail")
            }
        }
    }
    
}

class MyKeywordsService: Requestable {
    typealias NetworkData = MyKeywords
    static let shared = MyKeywordsService()
    
    //전체 키워드 리스트를 조회
    func getMyKeywords(completion: @escaping ([String]?) -> Void) {
        get(API.myKeywords) { result in
            switch result {
            case .networkSuccess(let data):
                if data.resResult.success == false {
                    return
                }
                print(data.resResult)
                completion(data.resResult.myKeywords)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("fail")
            }
        }
    }
    
}
