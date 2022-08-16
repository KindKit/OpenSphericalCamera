//
// OpenSphericalCamera
//

import Foundation
import KindKitJson

public extension OpenSphericalCamera.Command {
    
    struct Parameters< ParametersEncoder : IJsonModelEncoder > {
        
        public let name: String
        public let parameters: ParametersEncoder.Model
        
        public init(
            name: String,
            parameters: ParametersEncoder.Model
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
