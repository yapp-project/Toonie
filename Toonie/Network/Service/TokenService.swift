//
//  TokenService.swift
//  Toonie
//
//  Created by 박은비 on 16/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct TokenService: Requestable {
  typealias NetworkData = Token
  static let shared = TokenService()
  
  func getToken(completion : @escaping (String) -> Void) {
    get(API.token) { result in
      
      switch result {
      case .networkSuccess(let data):
        guard let token = data.resResult.token else { return }
        completion(token)
      case .networkError(let error):
        print(error)
      case .networkFail:
        print("Token Network Fail")
      }
    }
  }
}
