//
// OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera {
    
    struct State<
        SpecificDecoder : IJsonModelDecoder
    > {
        
        public let battery: Float
        public let specific: SpecificDecoder.JsonModelDecoded
        
    }
    
}

extension OpenSphericalCamera.State : IJsonModelDecoder {
    
    public static func decode(_ json: Json) throws -> Self {
        return .init(
            battery: try json.decode(Float.self, path: [ "batteryLevel" ]),
            specific: try json.decode(SpecificDecoder.self)
        )
    }
    
}
