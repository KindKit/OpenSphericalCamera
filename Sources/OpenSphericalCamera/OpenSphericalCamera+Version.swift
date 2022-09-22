//
// OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera {
    
    enum Version {
        
        case v1
        case v2
        
    }
    
}

public extension OpenSphericalCamera.Version {
    
    enum NumberRepresentable : Int {
        
        case v1 = 1
        case v2 = 2
        
    }
    
}

extension OpenSphericalCamera.Version.NumberRepresentable : IEnumDecodable {
    
    public var realValue: OpenSphericalCamera.Version {
        switch self {
        case .v1: return .v1
        case .v2: return .v2
        }
    }
    
}

extension OpenSphericalCamera.Version : IJsonDecoderAlias {
    
    public typealias JsonDecoder = Json.Coder.Enum< NumberRepresentable, NumberRepresentable.RawValue.JsonDecoder >
    
}

