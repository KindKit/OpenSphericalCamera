//
// OpenSphericalCamera
//

import Foundation

public extension OpenSphericalCamera {
    
    enum Error : Swift.Error {
        
        case invalidRequest
        case invalidResponse
        case noConnection
        case connectionLost
        case timeOut
        case busy
        case detail(Detail)
        
    }
    
}

public extension OpenSphericalCamera.Error {
    
    @inlinable
    var canRetry: Bool {
        switch self {
        case .invalidRequest, .invalidResponse, .detail: return false
        case .noConnection, .connectionLost, .timeOut, .busy: return true
        }
    }
    
}
