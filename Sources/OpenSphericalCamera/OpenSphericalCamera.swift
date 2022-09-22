//
// OpenSphericalCamera
//

import Foundation
import KindKit

public final class OpenSphericalCamera {
    
    public let provider: Api.Provider
    #if DEBUG
    public var logging: Api.Logging {
        set(value) { self.provider.logging = value }
        get { return self.provider.logging }
    }
    #endif

    public init(
        url: URL,
        configuration: URLSessionConfiguration = URLSessionConfiguration.default
    ) {
        self.provider = .init(
            url: url,
            configuration: configuration
        )
    }
    
}
