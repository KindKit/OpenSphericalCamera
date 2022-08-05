//
//  OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Query {
    
    struct Download {
        
        static func Request(url: URL) -> Api.Request {
            return .init(
                method: .get,
                path: .absolute(url)
            )
        }
        
        final class Response : OpenSphericalCamera.Query.Response< Data > {
            
            override func parse(meta: KindKitApi.Api.Response.Meta, result data: Data) throws -> Success {
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
    
}
