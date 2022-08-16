//
//  OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

public extension OpenSphericalCamera.Query {
    
    struct Info {
    }
    
}

public extension OpenSphericalCamera.Query.Info {
        
    static func request() -> Api.Request {
        return .init(
            method: .get,
            path: .relative("/osc/info"),
            timeout: 5
        )
    }
    
}

public extension OpenSphericalCamera.Query.Info {
    
    final class Response<
        ManufacturerDecoder : IJsonValueDecoder,
        ModelDecoder : IJsonValueDecoder,
        SerialNumberDecoder : IJsonValueDecoder,
        FirmwareVersionDecoder : IJsonValueDecoder,
        SpecificDecoder : IJsonModelDecoder
    > : OpenSphericalCamera.Query.Response<
        OpenSphericalCamera.Info<
            ManufacturerDecoder,
            ModelDecoder,
            SerialNumberDecoder,
            FirmwareVersionDecoder,
            SpecificDecoder
        >
    > {
        
        override func parse(meta: KindKitApi.Api.Response.Meta, result json: Json) throws -> Success {
            return try json.decode(Success.self)
        }
        
    }
    
}
