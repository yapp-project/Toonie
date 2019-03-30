//
//  MyPage.swift
//  Toonie
//
//  Created by 양어진 on 22/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

// MyPage Dummy Model
struct MyPage {
    var image: String
    var title: String
    var status: String
    
    init(image: String, title: String, status: String) {
        self.image = image
        self.title = title
        self.status = status
    }
}
