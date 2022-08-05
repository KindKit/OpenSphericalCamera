//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.State {
    
    enum StringRepresentable : String {
        
        case inProgress = "inProgress"
        case done = "done"
        
    }
    
}

extension OpenSphericalCamera.State.StringRepresentable : IEnumDecodable {
    
    var realValue: OpenSphericalCamera.State {
        switch self {
        case .inProgress: return .inProgress
        case .done: return .done
        }
    }
    
}

extension OpenSphericalCamera.State {
    
    typealias JsonDecoder = EnumJsonDecoder< StringRepresentable, StringRepresentable.RawValue.JsonDecoder >
    
}
