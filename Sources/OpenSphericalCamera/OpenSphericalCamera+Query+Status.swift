//
//  OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Query {
    
    struct Status {
        
        static func Request(id: String) throws -> Api.Request {
            let json = Json()
            try json.encode(String.self, value: id, path: "id")
            return .init(
                method: .post,
                path: .relative("/osc/commands/status"),
                body: .data(.json(json))
            )
        }
        
        final class Response< VendorDecoder : IJsonModelDecoder > : OpenSphericalCamera.Query.Response< OpenSphericalCamera.Result.Status< VendorDecoder > > {
            
            override func parse(meta: KindKitApi.Api.Response.Meta, result json: Json) throws -> Success {
                return try json.decode(Success.JsonDecoder.self)
            }
            
        }
        
    }
    
}
