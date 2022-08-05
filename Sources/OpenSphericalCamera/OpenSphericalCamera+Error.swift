//
// OpenSphericalCamera
//

import Foundation

public extension OpenSphericalCamera {
    
    enum Error : Swift.Error {
        
        case invalidRequest
        case invalidResponse
        case notConnected
        case connectionLost
        case timeOut
        case `internal`(Internal)
        
    }
    
}
