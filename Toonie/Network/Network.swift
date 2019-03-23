//
//  Network.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation
class Network {
    /// 일반적인 HTTP GET 통신 래퍼
    ///
    /// - Parameters:
    ///   - urlPath: 접속할 URL 문자열
    ///   - successHandler: 통신 성공시 호출할 핸들러
    ///   - errorHandler: 에러 발생시 호출할 핸들러
    static func get(_ urlPath: String, successHandler: ((Data, Int) -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlPath) else { return }
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                errorHandler?(error)
                session.finishTasksAndInvalidate()
                return
            }
            guard let data = data else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            successHandler?(data, statusCode)
            session.finishTasksAndInvalidate()
        }
        task.resume()
    }
    
    /// HTTP POST 통신 래퍼
    func post(_ url: String,
              parameters: [String: Any],
              completion: @escaping (Data?, Int?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        guard case let url? = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard case let httpBody? = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            else { return }
        request.httpBody = httpBody
        let task = session.dataTask(with: request) { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            completion(data, statusCode, error)
            session.finishTasksAndInvalidate()
        }
        task.resume()
    }
    
    /// HTTP UPLOAD 통신 래퍼
    func upload(_ data: Data, to url: String, completion: @escaping (Data?, Int?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        guard case let url? = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.uploadTask(with: request, from: data) { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            completion(data, statusCode, error)
            session.finishTasksAndInvalidate()
        }
        task.resume()
    }
}
