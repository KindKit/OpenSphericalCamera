//
//  OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Query {
    
    struct Command {
        
        static func Request(
            name: String
        ) throws -> Api.Request {
            let json = Json()
            try json.encode(String.self, value: name, path: "name")
            return .init(
                method: .post,
                path: .relative("/osc/commands/execute"),
                body: .data(.json(json))
            )
        }
        
        static func Request< ParametersEncoder : IJsonModelEncoder >(
            name: String,
            encoder: ParametersEncoder.Type,
            parameters: ParametersEncoder.Model
        ) throws -> Api.Request {
            let json = Json()
            try json.encode(String.self, value: name, path: "name")
            try json.encode(encoder, value: parameters, path: "parameters")
            return .init(
                method: .post,
                path: .relative("/osc/commands/execute"),
                body: .data(.json(json))
            )
        }
        
        final class ResultResponse< ResultDecoder : IJsonModelDecoder > : OpenSphericalCamera.Query.Response< OpenSphericalCamera.Result.Command< ResultDecoder > > {
            
            override func parse(meta: KindKitApi.Api.Response.Meta, result json: Json) throws -> Success {
                return try json.decode(Success.JsonDecoder.self)
            }
            
        }
        
        final class DirectResponse : OpenSphericalCamera.Query.Response< Data > {
            
            override func parse(meta: KindKitApi.Api.Response.Meta, result data: Data) throws -> Success {
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
    
}
