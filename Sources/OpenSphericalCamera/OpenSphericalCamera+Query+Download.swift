//
//  OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera.Query {
    
    struct Download {
    }
    
}

public extension OpenSphericalCamera.Query.Download {
        
    static func request(
        url: URL,
        timeout: TimeInterval
    ) -> Api.Request {
        return .init(
            method: .get,
            path: .absolute(url),
            timeout: timeout
        )
    }
    
}

public extension OpenSphericalCamera.Query.Download {
    
    final class Response : IApiDataResponse {
        
        public typealias Success = Data
        public typealias Failure = OpenSphericalCamera.Error
        public typealias Result = Swift.Result< Success, Failure >
        
        public init() {
        }
        
        public func parse(meta: Api.Response.Meta, data: Data) throws -> Result {
            if data.kk_isImage == true {
                return .success(data)
            } else {
                return .failure(.unknown)
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
