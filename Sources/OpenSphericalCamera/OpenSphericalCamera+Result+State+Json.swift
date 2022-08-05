//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Result.State {
    
    struct JsonDecoder : IJsonModelDecoder {
        
        static func decode(
            _ json: Json
        ) throws -> OpenSphericalCamera.Result.State<
            VendorDecoder
        > {
            return .init(
                sessionId: try json.decode(String.self, path: "sessionId"),
                batteryLevel: try json.decode(Float.self, path: "batteryLevel"),
                vendor: try json.decode(VendorDecoder.self)
            )
        }
        
    }
    
}
