//
// OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera.Command {
    
    struct Parameters< ParametersEncoder : IJsonModelEncoder > {
        
        public let name: String
        public let parameters: ParametersEncoder.JsonModelEncoded
        
        public init(
            name: String,
            parameters: ParametersEncoder.JsonModelEncoded
        ) {
            self.name = name
            self.parameters = parameters
        }

    }
    
}

extension OpenSphericalCamera.Command.Parameters : IOpenSphericalCameraCommandRequest {
    
    public struct JsonEncoder : IJsonModelEncoder {
        
        public static func encode(_ model: OpenSphericalCamera.Command.Parameters< ParametersEncoder >, json: Json) throws {
            try json.encode(String.self, value: model.name, path: "name")
            try json.encode(ParametersEncoder.self, value: model.parameters, path: "parameters")
        }
        
    }
    
}
