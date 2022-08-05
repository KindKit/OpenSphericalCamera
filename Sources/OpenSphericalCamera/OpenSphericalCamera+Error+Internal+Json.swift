//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Error.Internal {
    
    struct Decoder : IJsonModelDecoder {
        
        static func decode(_ json: Json) throws -> OpenSphericalCamera.Error.Internal {
            return OpenSphericalCamera.Error.Internal(
                code: try json.decode(String.self, path: "code"),
                message: try json.decode(String.self, path: "message")
            )
        }
        
    }
    
}
