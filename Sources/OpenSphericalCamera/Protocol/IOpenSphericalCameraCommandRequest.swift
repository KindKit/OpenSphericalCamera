//
// OpenSphericalCamera
//

import Foundation
import KindKit

public protocol IOpenSphericalCameraCommandRequest {
    
    associatedtype JsonEncoder : IJsonModelEncoder where Self == JsonEncoder.Model
    
}
