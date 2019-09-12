//
//  ForYouToonLists.swift
//  Toonie
//
//  Created by 이재은 on 07/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct ToonLists: Codable {
    let toonList: [ToonList]?
}

struct ToonList: Codable {
    let toonID: String?
    let toonName: String?
    let instaID: String?
    let instaUrl: String?
    let instaThumnailUrl: String?
    let instaInfo: String?
    let instaFollowerCount: String?
    let instaPostCount: String?
    let toonTagList: [String]?
    let curationTagList: [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case toonID, toonName, instaID, instaUrl, instaThumnailUrl,
        instaInfo, toonTagList, curationTagList
        case instaFollowerCount = "instafollowerCnt"
        case instaPostCount = "instaPostCnt"
    }
}


// ebpark : 신규, 둘러보기 상세, 전체보기
// 둘러보기 상세, 전체보기 : http://106.10.51.191/toon/category/1
struct NewToonLists: Codable {
    let tags: [Tags]?
    let toons: [Toons]?
}

struct Tags: Codable {
    let name: String?
}

struct Toons: Codable {
    let idx: Int?
    let imagePath: String?
}
c
