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
//    static let baseURL = "http://192.168.1.223:8080"
    static let baseURL = "http://10.10.98.117:8080"
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static let token: String = {
        return baseURL + "/token"
    }()
    
    static let keywords: String = {
        return baseURL + "/keywords"
    }()
     
}
