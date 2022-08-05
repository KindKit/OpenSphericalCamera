//
// OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitFlow
import KindKitJson

public extension OpenSphericalCamera {
    
    func state<
        VendorDecoder : IJsonModelDecoder
    >(
        vendor: VendorDecoder.Type,
        success: @escaping (OpenSphericalCamera.Result.State< VendorDecoder >) -> Void,
        failure: @escaping (OpenSphericalCamera.Error) -> Void
    ) -> ICancellable {
        return self.provider.send(
            request: OpenSphericalCamera.Query.State.Request(),
            response: OpenSphericalCamera.Query.State.Response< VendorDecoder >(),
            queue: .main,
            completed: { response in
                switch response {
                case .success(let result): success(result)
                case .failure(let error): failure(error)
                }
            }
        )
    }
    
    func state<
        VendorDecoder : IJsonModelDecoder
    >(
        vendor: VendorDecoder.Type
    ) -> Pipeline< Swift.Result< Void, Never >, Swift.Result< OpenSphericalCamera.Result.State< VendorDecoder >, OpenSphericalCamera.Error > > {
        return Flow< Void, Never >()
            .apiQuery(
                provider: self.provider,
                dispatch: .main,
                request: { _ in
                    return OpenSphericalCamera.Query.State.Request()
                },
                response: { _ in
                    return OpenSphericalCamera.Query.State.Response< VendorDecoder >()
                },
                completion: { _, output, elapsed in
                    switch output {
                    case .success:
                        return .done
                    case .failure:
                        if elapsed < 30 {
                            return .retry(delay: 0.1)
                        }
                        return .done
                    }
                }
            )
            .pipeline()
    }
    
}
