//
//  FavoriteService.swift
//  Toonie
//
//  Created by 이재은 on 28/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct FavoriteService: Requestable {
    typealias NetworkData = WorkList
    static let shared = FavoriteService()
    
    ///선택한 툰 즐겨찾기 post 통신
    func postFavoriteToon(params: [String: Any],
                          completion: @escaping () -> Void) {
        post((API.myFavoriteList(CommonUtility.getUserToken() ?? "")), params: params) { result in
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
    
    /// 찜한 작품 내역 get 통신
    func getFavoriteToon(completion: @escaping ([ToonList]?) -> Void) {
        get(API.myFavoriteList(CommonUtility.getUserToken() ?? "")) { result in
            switch result {
            case .networkSuccess(let data):
                guard let toonList = data.resResult.toonList else {
                    return
                }
                completion(toonList)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("FavoriteToon get fail")
            }
        }
    }
}
