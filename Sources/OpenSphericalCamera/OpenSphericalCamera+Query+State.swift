//
//  OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

public extension OpenSphericalCamera.Query {
    
    struct State {
    }
    
}

public extension OpenSphericalCamera.Query.State {
        
    static func request() -> Api.Request {
        return .init(
            method: .post,
            path: .relative("/osc/state")
        )
    }
    
}

public extension OpenSphericalCamera.Query.State {
    
    final class Response<
        SpecificDecoder : IJsonModelDecoder
    > : OpenSphericalCamera.Query.Response<
        OpenSphericalCamera.State<
            SpecificDecoder
        >
    > {
        
        override func parse(meta: KindKitApi.Api.Response.Meta, result json: Json) throws -> Success {
            return try json.decode(Success.self)
        }
        
    }
    
}