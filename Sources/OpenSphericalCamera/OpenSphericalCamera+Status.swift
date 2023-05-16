//
// OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera {
    
    struct Status< SpecificDecoder : IJsonModelDecoder > {
        
        public let state: OpenSphericalCamera.Command.State
        public let specific: SpecificDecoder.JsonModelDecoded
        
    }
    
}

extension OpenSphericalCamera.Status : IJsonModelDecoder {
    
    public static func decode(_ json: Json) throws -> Self {
        return .init(
            state: try json.decode(OpenSphericalCamera.Command.State.self, path: [ "state" ]),
            specific: try json.decode(SpecificDecoder.self)
        )
    }
    
}

