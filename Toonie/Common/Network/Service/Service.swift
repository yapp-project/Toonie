import Foundation

struct TokenService: Requestable {
    typealias NetworkData = Token
    static let shareInstance = TokenService()
    
    func getToken(url: String,
                  params: [String: Any]? = nil,
                  completion: @escaping (NetworkResult<Any>) -> Void) {
        get(url, params: params) { (result) in
            
            switch result {
            case .networkSuccess(let successResult):
                completion(.networkSuccess((successResult.resResult)))
            case .networkError(let errResult):
                completion(.networkError((errResult.resCode, errResult.msg)))
            case .networkFail:
                completion(.networkFail)
            }
        }
    }
}
