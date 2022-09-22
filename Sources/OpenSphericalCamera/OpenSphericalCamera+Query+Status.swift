//
//  OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera.Query {
    
    struct Status {
    }
    
}

public extension OpenSphericalCamera.Query.Status {
        
    static func request(
        id: String
    ) throws -> Api.Request {
        let json = Json()
        try json.encode(String.self, value: id, path: "id")
        return .init(
            method: .post,
            path: .relative("/osc/commands/status"),
            body: .data(.json(json))
        )
    }
    
}

public extension OpenSphericalCamera.Query.Status {
        
    final class Response<
        SpecificDecoder : IJsonModelDecoder
    > : OpenSphericalCamera.Query.Response<
        OpenSphericalCamera.Status<
            SpecificDecoder
        >
    > {
        
        override func parse(meta: Api.Response.Meta, result json: Json) throws -> Success {
            return try json.decode(Success.self)
        }
        
    }
    
}
