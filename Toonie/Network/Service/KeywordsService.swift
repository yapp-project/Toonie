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
    
    ///전체 키워드 리스트를 조회
    func getMyKeywords(completion: @escaping ([String]?) -> Void) {
        get(API.myKeywordsToken(CommonUtility.getUserToken() ?? "")) { result in
            switch result {
            case .networkSuccess(let data):
                if data.resResult.success == false {
                    return
                }
                completion(data.resResult.myKeywords)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("fail")
            }
        }
    }
    
    ///선택한 키워드 post 통신
    func postMyKeywords(params: [String: Any],
                        completion: @escaping () -> Void) {
        post((API.myKeywordsToken(CommonUtility.getUserToken() ?? "")),
             params: params) { result in
                switch result {
                case .networkSuccess(let data):
                    if data.resResult.success == false {
                        return
                    }
                    completion()
                case .networkError(let error):
                    print(error)
                case .networkFail:
                    print("fail")
                }
        }
    }
}

class KeywordToonListService: Requestable {
    typealias NetworkData = KeywordToonList
    static let shared = KeywordToonListService() 
    //전체 키워드 리스트를 조회
    func getKeywords(keyword: String,
                     completion: @escaping ([String]?) -> Void) {
        get(API.keywordInfo(keyword)) { result in
            switch result {
            case .networkSuccess(let data):
                print("여기\(API.keywordInfo(keyword))")
                completion(data.resResult.toonTags)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("fail")
            }
        }
    }
}

class KeywordToonAllListService: Requestable {
    typealias NetworkData = ForYouToonLists
    static let shared = KeywordToonAllListService()

    func getKeywordToonAllList(keyword: String,
                               completion: @escaping ([ToonList]?) -> Void) {
        get(API.toons + "/keyword/\(keyword)") { result in
            print("APIZZZ \(API.toons + "/keyword/\(keyword)")")
            switch result {
            case .networkSuccess(let data):
                guard let toonList = data.resResult.toonList else { return }
                completion(toonList)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("KeywordToonAllListService Network Fail")
            }
        }
    }
}
