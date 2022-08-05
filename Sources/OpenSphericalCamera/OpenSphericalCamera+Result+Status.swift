//
// OpenSphericalCamera
//

import Foundation
import KindKitJson

public extension OpenSphericalCamera.Result {
    
    struct Status<
        ResultDecoder : IJsonModelDecoder
    > {
        
        public let state: OpenSphericalCamera.State
        public let progress: Float?
        public let result: ResultDecoder.Model?
        
    }
    
}
