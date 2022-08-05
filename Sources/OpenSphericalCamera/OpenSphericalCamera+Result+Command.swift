//
// OpenSphericalCamera
//

import Foundation
import KindKitJson

public extension OpenSphericalCamera.Result {
    
    struct Command<
        ResultDecoder : IJsonModelDecoder
    > {
        
        public let state: OpenSphericalCamera.State
        public let id: String?
        public let progress: Float?
        public let result: ResultDecoder.Model?

    }
    
}
