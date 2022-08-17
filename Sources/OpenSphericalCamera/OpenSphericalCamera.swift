//
// OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitJson

public final class OpenSphericalCamera {
    
    public let provider: KindKitApi.Api.Provider
    #if DEBUG
    public var logging: Api.Logging {
        set(value) { self.provider.logging = value }
        get { return self.provider.logging }
    }
    #endif

    public init(url: URL) {
        self.provider = .init(
            url: url
        )
    }
    
}
