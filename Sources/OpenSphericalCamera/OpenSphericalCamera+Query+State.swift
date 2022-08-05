//
//  OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Query {
    
    struct State {
        
        static func Request() -> Api.Request {
            return .init(
                method: .post,
                path: .relative("/osc/state")
            )
        }
        
        final class Response< VendorDecoder : IJsonModelDecoder > : OpenSphericalCamera.Query.Response< OpenSphericalCamera.Result.State< VendorDecoder > > {
            
            override func parse(meta: KindKitApi.Api.Response.Meta, result json: Json) throws -> Success {
                return try json.decode(Success.JsonDecoder.self)
            }
            
        }
        
    }
    
}
