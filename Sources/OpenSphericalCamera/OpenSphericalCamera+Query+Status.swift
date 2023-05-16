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
        id: String,
        timeout: TimeInterval
    ) throws -> Api.Request {
        return .init(
            method: .post,
            path: .relative("/osc/commands/status"),
            body: .data(
                try .json({ json in
                    try json.encode(String.self, value: id, path: [ "id" ])
                })
            ),
            timeout: timeout
        )
    }
    
}

public extension OpenSphericalCamera.Query.Status {
        
    final class Response< SpecificDecoder : IJsonModelDecoder > : IApiJsonResponse {
        
        public typealias JsonDecoder = OpenSphericalCamera.Status< SpecificDecoder >.JsonModelDecoded
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
