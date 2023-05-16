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
    
    final class Response< ManufacturerDecoder : IJsonValueDecoder, ModelDecoder : IJsonValueDecoder, SerialNumberDecoder : IJsonValueDecoder, FirmwareVersionDecoder : IJsonValueDecoder, SpecificDecoder : IJsonModelDecoder > : IApiJsonResponse {
        
        public typealias JsonDecoder = OpenSphericalCamera.Info< ManufacturerDecoder, ModelDecoder, SerialNumberDecoder, FirmwareVersionDecoder, SpecificDecoder >.JsonModelDecoded
        public typealias Success = JsonDecoder.JsonModelDecoded
        public typealias Failure = OpenSphericalCamera.Error
        public typealias Result = Swift.Result< Success, Failure >
        
        public init() {
        }
        
        public func parse(meta: Api.Response.Meta, json: Json) throws -> Result {
            return try json.decode(
                success: { json in
                    return try json.decode(JsonDecoder.self)
                },
                failure: { json in
                    return .detail(try json.decode(OpenSphericalCamera.Error.Detail.self, path: [ "error" ]))
                }
            )
        }
        
        public func failure(meta: Api.Response.Meta) -> Failure? {
            switch meta.statusCode {
            case 503: return .busy
            default: return nil
            }
        }
        
        public func failure(request: Api.Error.Request) -> Failure {
            return .request(request)
        }
        
        public func failure(network: Api.Error.Network) -> Failure {
            return .network(network)
        }
        
        public func failure(parse: Api.Error.Parse) -> Failure {
            return .parse(parse)
        }
        
        public func failure(parse: Json.Error.Coding) -> Failure {
            return .json(parse)
        }
        
        public func failure(error: Swift.Error) -> Failure {
            return .unknown
        }
        
    }
    
}
