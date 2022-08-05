//
// OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitFlow
import KindKitJson

public extension OpenSphericalCamera {
    
    func download(
        url: URL,
        success: @escaping (Data) -> Void,
        failure: @escaping (OpenSphericalCamera.Error) -> Void
    ) -> ICancellable {
        return self.provider.send(
            request: OpenSphericalCamera.Query.Download.Request(url: url),
            response: OpenSphericalCamera.Query.Download.Response(),
            queue: .main,
            completed: { response in
                switch response {
                case .success(let result): success(result)
                case .failure(let error): failure(error)
                }
            }
        )
    }
    
    func download() -> Pipeline< Swift.Result< URL, Never >, Swift.Result< Data, OpenSphericalCamera.Error > > {
        return Flow< URL, Never >()
            .apiQuery(
                provider: self.provider,
                dispatch: .main,
                request: { input in
                    return OpenSphericalCamera.Query.Download.Request(url: input)
                },
                response: { _ in
                    return OpenSphericalCamera.Query.Download.Response()
                },
                completion: { _, output, elapsed in
                    switch output {
                    case .success:
                        return .done
                    case .failure:
                        if elapsed < 120 {
                            return .retry(delay: 0.1)
                        }
                        return .done
                    }
                }
            )
            .pipeline()
    }
    
}
