//
//  NetworkResult.swift
//  Toonie
//
//  Created by 양어진 on 30/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case networkSuccess(T)
    case networkError((resCode : Int, msg : String))
    case networkFail
}
