//
//  ToonOfTag.swift
//  Toonie
//
//  Created by 이재은 on 16/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

struct ToonOfTag: Codable {
  let toonTag: String?
  let toonInfoList: [ToonInfoList]?
}

struct ToonInfoList: Codable {
  let toonID: String?
  let toonName: String?
  let instaID: String?
  let instaUrl: String?
  let instaThumnailUrl: String?
  let instaInfo: String?
  let instafollowerCount: String?
  let instaPostCount: String?
  let instaLatestPostUrl: String?
  let toonTagList: [String]?
  
  enum CodingKeys: String, CodingKey {
    
    case toonID, toonName, instaID, instaUrl, instaThumnailUrl,
    instaInfo, instaLatestPostUrl, toonTagList
    case instafollowerCount = "instafollowerCnt"
    case instaPostCount = "instaPostCnt"
  }
}
