//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

public extension OpenSphericalCamera.Error {
    
    struct Detail {
        
        public let code: String
        public let message: String
        
    }
    
}

extension OpenSphericalCamera.Error.Detail : IJsonModelDecoder {
    
    public static func decode(_ json: Json) throws -> Self {
        return OpenSphericalCamera.Error.Detail(
            code: try json.decode(String.self, path: "code"),
            message: try json.decode(String.self, path: "message")
        )
    }
    
}
