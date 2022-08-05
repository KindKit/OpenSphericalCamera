//
//  OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Query {
    
    struct Info {
        
        static func Request() -> Api.Request {
            return .init(
                method: .get,
                path: .relative("/osc/info"),
                timeout: 5
            )
        }
        
        final class Response<
            ManufacturerDecoder : IJsonValueDecoder,
            ModelDecoder : IJsonValueDecoder,
            SerialNumberDecoder : IJsonValueDecoder,
            FirmwareVersionDecoder : IJsonValueDecoder,
            VendorDecoder : IJsonModelDecoder
        > : OpenSphericalCamera.Query.Response< OpenSphericalCamera.Result.Info< ManufacturerDecoder, ModelDecoder, SerialNumberDecoder, FirmwareVersionDecoder, VendorDecoder > > {
            
            override func parse(meta: KindKitApi.Api.Response.Meta, result json: Json) throws -> Success {
                return try json.decode(Success.JsonDecoder.self)
            }
            
        }
        
    }
    
}
