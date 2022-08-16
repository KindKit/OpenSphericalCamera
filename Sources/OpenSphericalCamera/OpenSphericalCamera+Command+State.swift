//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

public extension OpenSphericalCamera.Command {
    
    enum State {
        
        case inProgress
        case done
        
    }
    
}

public extension OpenSphericalCamera.Command.State {
    
    enum StringRepresentable : String {
        
        case inProgress = "inProgress"
        case done = "done"
        
    }
    
}

extension OpenSphericalCamera.Command.State.StringRepresentable : IEnumDecodable {
    
    public var realValue: OpenSphericalCamera.Command.State {
        switch self {
        case .inProgress: return .inProgress
        case .done: return .done
        }
    }
    
}

extension OpenSphericalCamera.Command.State : IJsonDecoderAlias {
    
    public typealias JsonDecoder = EnumJsonDecoder< StringRepresentable, StringRepresentable.RawValue.JsonDecoder >
    
}

