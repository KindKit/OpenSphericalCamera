//
// OpenSphericalCamera
//

import KindKit

public extension OpenSphericalCamera {
    
    enum Error : Swift.Error {
        
        case unknown
        case request(Api.Error.Request)
        case network(Api.Error.Network)
        case parse(Api.Error.Parse)
        case json(Json.Error.Coding)
        case detail(Detail)
        case busy
        
    }
    
}

public extension OpenSphericalCamera.Error {
    
    var canRetry: Bool {
        switch self {
        case .unknown: return false
        case .request: return false
        case .network(let error):
            switch error {
            case .notConnected: return true
            case .lost: return true
            case .untrusted: return false
            case .timeout: return true
            case .cancelled: return false
            }
        case .parse: return false
        case .json: return false
        case .detail: return false
        case .busy: return true
        }
    }
    
}
