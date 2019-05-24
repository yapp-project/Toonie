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
    static let baseURL = "http://101.101.167.91:8080"
    
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
    
    static let keywords = {
        return baseURL + "/keywords"
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
    static let myKeywordsToken = { (token) in
        return myKeywords + "/" + token
    }
    
    //kewords/:keyword
    static let keywordInfo = { (keyword) in
        return keywords + "/" + keyword
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
    
}
