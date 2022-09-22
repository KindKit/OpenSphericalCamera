//
//  OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera.Query {
    
    struct Download {
    }
    
}

public extension OpenSphericalCamera.Query.Download {
        
    static func request(
        url: URL
    ) -> Api.Request {
        return .init(
            method: .get,
            path: .absolute(url)
        )
    }
    
}

public extension OpenSphericalCamera.Query.Download {
    
    final class Response : OpenSphericalCamera.Query.Response< Data > {
        
        override func parse(meta: Api.Response.Meta, result data: Data) throws -> Success {
            guard let statusCode = meta.statusCode else {
                throw Failure.invalidResponse
            }
            switch statusCode {
            case 200..<300: return data
            default: throw Failure.invalidResponse
            }
        }
        
    }
    
}
