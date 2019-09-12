//
//  KeywordsService.swift
//  Toonie
//
//  Created by 박은비 on 20/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

struct CategorysService: Requestable {
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

struct MyCategorysService: Requestable {
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
        anyTypeParamsPost(API.myCategorysToken(CommonUtility.getUserToken() ?? ""),
                          params: params) { (result) in
                            switch result {
                            case .networkSuccess( _):
                                completion()
                            case .networkError(let error):
                                print(error)
                            case .networkFail:
                                print("fail")
                            }
        }
    }
}

struct CategoryOfToon: Requestable {
    typealias NetworkData = [Categorys]
    static let shared = CategoryOfToon()
}



class KeywordToonListService: Requestable {
    typealias NetworkData = KeywordToonList?
    static let shared = KeywordToonListService() 
    //전체 키워드 리스트를 조회
    func getKeywords(keyword: String,
                     completion: @escaping ([String]?) -> Void) {
        get(API.keywordInfo(keyword)) { result in
            switch result {
            case .networkSuccess(let data):
                completion(data.resResult?.toonTags)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("fail")
            }
        }
    }
}

class CategoryToonAllListService: Requestable {
    typealias NetworkData = NewToonLists
    static let shared = CategoryToonAllListService()

    // ebpark : 하기 메서드 더 이상 쓰이지 않습니다. 클로저 리턴값 임시로 바꿔놓음
    func getKeywordToonAllList(keyword: String,
                               completion: @escaping ([ToonList]?) -> Void) {
        get(API.toons + "/keyword/\(keyword)") { result in
            switch result {
            case .networkSuccess(let data):
//                guard let toonList = data.resResult.toonList else { return }
//                                completion(toonList)
                let imsi: [ToonList]? = nil
                guard let toonList = imsi else { return }
                
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
                //                guard let toonList = data.resResult.toonList else { return }
                //                                completion(toonList)
                let imsi: [ToonList]? = nil
                guard let toonList = imsi else { return }
                
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
    
    // ebpark : 신규, 둘러보기 상세, 전체보기
    // 둘러보기 상세, 전체보기 : http://106.10.51.191/toon/category/1
    func getCategoryToonAllList(index: Int,
                               completion: @escaping (NewToonLists?) -> Void) {
        get(API.categoryToonAllList("\(index)")) { result in
            switch result {
            case .networkSuccess(let data):
                completion(data.resResult)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("getCategoryToonAllList Network Fail")
            }
        }
    }
}
