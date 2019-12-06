//
//  DetailToonService.swift
//  Toonie
//
//  Created by 이재은 on 21/04/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

struct DetailToonService: Requestable {
    typealias NetworkData = DetailToon
    static let shared = DetailToonService()
    
    /// 툰 상세 화면 정보 조회
    func getDetailToon(toonId: String, completion: @escaping (DetailToon?) -> Void) {
        get(API.toons+"/\(toonId)") { result in
            switch result {
            case .networkSuccess(let data):
                let detailToon = data.resResult.self
                completion(detailToon)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("DetailToon Network Fail")
            }
        }
    }
    
}
