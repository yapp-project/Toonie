//
//  FavoriteService.swift
//  Toonie
//
//  Created by 이재은 on 28/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct FavoriteService: Requestable {
    typealias NetworkData = FavoriteToon
    static let shared = FavoriteService()
    
    ///선택한 툰 즐겨찾기 post 통신
    func postFavoriteToon(params: [String: Any],
                          completion: @escaping () -> Void) {
        post((API.myWorklist),
             params: params) { result in
                switch result {
                case .networkSuccess(let data):
                    if data.resResult.success == false {
                        return
                    }
                    completion()
                    print("FavoriteToon post success")
                case .networkError(let error):
                    print(error)
                case .networkFail:
                    print("FavoriteToon post fail")
                }
        }
    }
}
