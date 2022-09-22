//
// OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera.Command {
    
    struct Simple {
        
        public let name: String
        
        public init(
            name: String
        ) {
            self.name = name
        }

    }
    
}

extension OpenSphericalCamera.Command.Simple : IOpenSphericalCameraCommandRequest {
    
    public struct JsonEncoder : IJsonModelEncoder {
        
        public static func encode(_ model: OpenSphericalCamera.Command.Simple, json: Json) throws {
            try json.encode(String.self, value: model.name, path: "name")
        }
        
    }
    
}

