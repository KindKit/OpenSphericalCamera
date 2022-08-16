//
// OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

public final class OpenSphericalCamera {
    
    public let provider: KindKitApi.Api.Provider

    public init(url: URL) {
        self.provider = .init(
            url: url
        )
    }
    
}
