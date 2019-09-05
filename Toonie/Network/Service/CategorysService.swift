//
//  KeywordsService.swift
//  Toonie
//
//  Created by 박은비 on 20/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class CategorysService: Requestable {
    typealias NetworkData = [Categorys]
    static let shared = CategorysService()
    
    //전체 키워드 리스트를 조회
    func getCategorys(completion: @escaping ([Categorys]) -> Void) {
        get(API.categorys) { result in
            switch result {
            case .networkSuccess(let data):
                completion(data.resResult)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("fail")
            }
        }
    }
    
}

class MyCategorysService: Requestable {
    typealias NetworkData = [Categorys]
    static let shared = MyCategorysService()
    
    ///전체 키워드 리스트를 조회
    func getMyCategorys(completion: @escaping ([Categorys]?) -> Void) {
        get(API.myCategorysToken(CommonUtility.getUserToken() ?? "")) { result in
            switch result {
            case .networkSuccess(let data):
                completion(data.resResult)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("fail")
            }
        }
    }
    
    ///선택한 키워드 post 통신
    func postMyCategorys(params: [String],
                         completion: @escaping () -> Void) {
        
        print("asdf \(API.myCategorysToken(CommonUtility.getUserToken() ?? ""))")
        anyTypeParamsPost(API.myCategorysToken(CommonUtility.getUserToken() ?? ""),
                          params: params) { (result) in
                            switch result {
                            case .networkSuccess(let data):
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
    typealias NetworkData = ToonLists
    static let shared = KeywordToonAllListService()

    func getKeywordToonAllList(keyword: String,
                               completion: @escaping ([ToonList]?) -> Void) {
        get(API.toons + "/keyword/\(keyword)") { result in
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
    
    func getKeywordToonAllList(keyword: String,
                               completion: @escaping ([ToonList]?) -> Void,
                               failer: @escaping () -> Void)  {
        get(API.toons + "/keyword/\(keyword)") { result in
            switch result {
            case .networkSuccess(let data):
                guard let toonList = data.resResult.toonList else { return }
                completion(toonList)
            case .networkError(let error):
                print(error)
                failer()
            case .networkFail:
                print("KeywordToonAllListService Network Fail")
                failer()
            }
        }
    }
}
