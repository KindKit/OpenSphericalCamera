//
//  OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera.Query {
    
    struct Info {
    }
    
}

public extension OpenSphericalCamera.Query.Info {
        
    static func request(
        timeout: TimeInterval
    ) -> Api.Request {
        return .init(
            method: .get,
            path: .relative("/osc/info"),
            timeout: timeout
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
        
        override func parse(meta: Api.Response.Meta, result json: Json) throws -> Success {
            return try json.decode(Success.self)
        }
        
    }
    
}
