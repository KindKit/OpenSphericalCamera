//
// OpenSphericalCamera
//

import Foundation
import KindKit

public final class OpenSphericalCamera {
    
    public let provider: Api.Provider
    public var logging: Api.Logging {
        set(value) { self.provider.logging = value }
        get { return self.provider.logging }
    }
    
    public init(
        url: URL,
        configuration: URLSessionConfiguration = URLSessionConfiguration.default,
        logging: Api.Logging = .never
    ) {
        self.provider = .init(
            url: url,
            authenticationChallenge: .allowUntrusted,
            configuration: configuration,
            logging: logging
        )
    }
    
}
