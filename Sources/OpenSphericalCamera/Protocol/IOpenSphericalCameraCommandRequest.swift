//
// OpenSphericalCamera
//

import Foundation
import KindKitJson

public protocol IOpenSphericalCameraCommandRequest {
    
    associatedtype JsonEncoder : IJsonModelEncoder where Self == JsonEncoder.Model
    
}
