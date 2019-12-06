//
//  TokenService.swift
//  Toonie
//
//  Created by 박은비 on 16/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

struct TokenService: Requestable {
    typealias NetworkData = Token
    static let shared = TokenService()
    
    ///토큰 발급
    func getToken(completion : @escaping (String) -> Void) { 
        unprocessedPost(API.token,
                        params: nil) { (result) in
                            switch result {
                            case .networkSuccess(let data):
                                if let token = String(data: data, encoding: String.Encoding.utf8) {
                                    print("token \(token)")
                                    completion(token)
                                }
                            case .networkError(let error):
                                print(error)
                            case .networkFail:
                                print("Token Network Fail")
                            }
        }
    }
}
