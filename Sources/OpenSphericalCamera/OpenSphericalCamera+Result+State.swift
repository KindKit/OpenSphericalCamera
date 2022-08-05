//
// OpenSphericalCamera
//

import Foundation
import KindKitJson

public extension OpenSphericalCamera.Result {
    
    struct State<
        VendorDecoder : IJsonModelDecoder
    > {
        
        public let sessionId: String?
        public let batteryLevel: Float
        public let vendor: VendorDecoder.Model
        
    }
    
}
