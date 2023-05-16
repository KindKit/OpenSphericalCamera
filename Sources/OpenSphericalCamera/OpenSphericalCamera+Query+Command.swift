//
//  OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera.Query {
    
    struct Command {
    }
    
}

public extension OpenSphericalCamera.Query.Command {
        
    static func request<
        Request : IOpenSphericalCameraCommandRequest
    >(
        request: Request,
        timeout: TimeInterval
    ) throws -> Api.Request {
        return .init(
            method: .post,
            path: .relative("/osc/commands/execute"),
            body: .data(try .json({ json in
                try json.encode(Request.JsonEncoder.self, value: request)
            })),
            timeout: timeout
        )
    }
    
}

public extension OpenSphericalCamera.Query.Command {
    
    final class ResultResponse< Response : IJsonModelDecoder > : IApiJsonResponse {
        
        public typealias JsonDecoder = OpenSphericalCamera.Command.Response< Response >.JsonModelDecoded
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
    
    final class DataResponse : IApiDataResponse {

        public typealias Success = Data
        public typealias Failure = OpenSphericalCamera.Error
        public typealias Result = Swift.Result< Success, Failure >
        
        public init() {
        }
        
        public func parse(meta: Api.Response.Meta, data: Data) throws -> Result {
            guard let statusCode = meta.statusCode else {
                return .failure(.unknown)
            }
            switch statusCode {
            case 200..<300: return .success(data)
            default: return .failure(.unknown)
            }
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
