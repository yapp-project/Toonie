//
//  CurationTagService.swift
//  Toonie
//
//  Created by 양어진 on 25/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct CurationTagService: Requestable {
    typealias NetworkData = ToonOfTag
    static let shared = CurationTagService()
    
    func getCurationTagList(tagName: String, completion: @escaping ([ToonInfoList]?) -> Void) {
        let tagURL = API.tags + "/curationtags/" + tagName
        get(tagURL) { result in
            switch result {
            case .networkSuccess(let data):
                guard let toonOfTags = data.resResult.toonInfoList else { return }
                completion(toonOfTags)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("ToonofTag Network Fail")
            }
        }
    }
}
