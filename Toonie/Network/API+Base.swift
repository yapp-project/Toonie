//
//  API+Base.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation
/*
 API의 기본 형태
 Base URL과 JSONDecoder의 디코딩 전략 설정
 */
class API {
    static let baseURL = "http://106.10.51.191"
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static let chkToonieUpdate = {
        return baseURL + "/version"
    }()
    
    static let token = {
        return baseURL + "/token"
    }()
    
    static let categorys = {
        return baseURL + "/category"
    }()
    
    //    static let myKeywords = {
    //        return baseURL + "/mykeywords/\(String(describing: CommonUtility.userToken))"
    //    }()
    
    static let myKeywords = {
        return baseURL + "/mykeywords"
    }()
    
    static let tags = {
        return baseURL + "/tags"
    }()
    
    static let forYouToons = {(token) in
        return baseURL + "/tags/token/" + token
    }
    
    static let toons = {
        return baseURL + "/toons"
    }()
    
    //mykeywords/:token
    static let myCategorysToken = { (token) in
        return categorys + "/token/" + token
    }
    
    // ebpark : 신규, 둘러보기 상세, 전체보기
    // +++ 기존에 기존 값 최대한 활용해서(예 : retrun categorys + "/token/" + token) 쓰는 방식은 너무 헷갈린것 같습니다. 하기처럼 hostURL + "나머지" 방식으로 맞추는게 나을것 같은데 다들 어떠세여?
    // 둘러보기 상세, 전체보기 : http://106.10.51.191/toon/category/1
    static let categoryToonAllList = { (index) in
        return baseURL + "/toon/category/" + index
    }
    
    //kewords/:keyword
    static let keywordInfo = { (keyword) in
        return categorys + "/" + keyword
    }
    
    static let worklist = {
        return baseURL + "/worklist"
    }()
    
    static let myFavoriteList = { (token) in
        return baseURL + "/worklist/" + token + "/default"
    }
    
    static let myLatestList = { (token) in
        return baseURL + "/worklist/" + token + "/latest"
    }
    
    static let tagFavoriteList = { (token) in
        return baseURL + "/tags/worklist/" + token + "/default"
    }
    
    static let tagLatestList = { (token) in
        return baseURL + "/tags/worklist/" + token + "/latest"
    }
    
}
