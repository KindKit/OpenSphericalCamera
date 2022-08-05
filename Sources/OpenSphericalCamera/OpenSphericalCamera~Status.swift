//
// OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitFlow
import KindKitJson

public extension OpenSphericalCamera {
    
    func status<
        VendorDecoder : IJsonModelDecoder
    >(
        id: String,
        vendor: VendorDecoder.Type,
        success: @escaping (OpenSphericalCamera.Result.Status< VendorDecoder >) -> Void,
        failure: @escaping (OpenSphericalCamera.Error) -> Void
    ) -> ICancellable {
        return self.provider.send(
            request: try OpenSphericalCamera.Query.Status.Request(id: id),
            response: OpenSphericalCamera.Query.Status.Response< VendorDecoder >(),
            queue: .main,
            completed: { response in
                switch response {
                case .success(let result): success(result)
                case .failure(let error): failure(error)
                }
            }
        )
    }
    
    func status<
        VendorDecoder : IJsonModelDecoder
    >(
        vendor: VendorDecoder.Type
    ) -> Pipeline< Swift.Result< String, Never >, Swift.Result< OpenSphericalCamera.Result.Status< VendorDecoder >, OpenSphericalCamera.Error > > {
        return Flow< String, Never >()
            .apiQuery(
                provider: self.provider,
                dispatch: .main,
                request: { input in
                    return try OpenSphericalCamera.Query.Status.Request(id: input)
                },
                response: { _ in
                    return OpenSphericalCamera.Query.Status.Response< VendorDecoder >()
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
