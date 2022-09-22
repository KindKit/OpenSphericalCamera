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
        request: Request
    ) throws -> Api.Request {
        let json = Json()
        try json.encode(Request.JsonEncoder.self, value: request)
        return .init(
            method: .post,
            path: .relative("/osc/commands/execute"),
            body: .data(.json(json))
        )
    }
    
}

public extension OpenSphericalCamera.Query.Command {
    
    final class ResultResponse< Response : IJsonModelDecoder > : OpenSphericalCamera.Query.Response< OpenSphericalCamera.Command.Response< Response > > {
        
        override func parse(meta: Api.Response.Meta, result json: Json) throws -> Success {
            return try json.decode(Success.self)
        }
        
    }
    
    final class DataResponse : OpenSphericalCamera.Query.Response< Data > {
        
        override func parse(meta: Api.Response.Meta, result data: Data) throws -> Success {
            guard let statusCode = meta.statusCode else {
                throw Failure.invalidResponse
            }
            switch statusCode {
            case 200..<300: return data
            default: throw Failure.invalidResponse
            }
        }
        
    }
    
}
