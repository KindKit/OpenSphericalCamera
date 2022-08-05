//
// OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitFlow
import KindKitJson

public extension OpenSphericalCamera {
    
    func info<
        ManufacturerDecoder : IJsonValueDecoder,
        ModelDecoder : IJsonValueDecoder,
        SerialNumberDecoder : IJsonValueDecoder,
        FirmwareVersionDecoder : IJsonValueDecoder,
        VendorDecoder : IJsonModelDecoder
    >(
        manufacturer: ManufacturerDecoder.Type,
        model: ModelDecoder.Type,
        serialNumber: SerialNumberDecoder.Type,
        firmwareVersion: FirmwareVersionDecoder.Type,
        vendor: VendorDecoder.Type,
        success: @escaping (OpenSphericalCamera.Result.Info< ManufacturerDecoder, ModelDecoder, SerialNumberDecoder, FirmwareVersionDecoder, VendorDecoder >) -> Void,
        failure: @escaping (OpenSphericalCamera.Error) -> Void
    ) -> ICancellable {
        return self.provider.send(
            request: OpenSphericalCamera.Query.Info.Request(),
            response: OpenSphericalCamera.Query.Info.Response< ManufacturerDecoder, ModelDecoder, SerialNumberDecoder, FirmwareVersionDecoder, VendorDecoder >(),
            queue: .main,
            completed: { response in
                switch response {
                case .success(let result): success(result)
                case .failure(let error): failure(error)
                }
            }
        )
    }
    
    func info<
        ManufacturerDecoder : IJsonValueDecoder,
        ModelDecoder : IJsonValueDecoder,
        SerialNumberDecoder : IJsonValueDecoder,
        FirmwareVersionDecoder : IJsonValueDecoder,
        VendorDecoder : IJsonModelDecoder
    >(
        manufacturer: ManufacturerDecoder.Type,
        model: ModelDecoder.Type,
        serialNumber: SerialNumberDecoder.Type,
        firmwareVersion: FirmwareVersionDecoder.Type,
        vendor: VendorDecoder.Type
    ) -> Pipeline< Swift.Result< Void, Never >, Swift.Result< OpenSphericalCamera.Result.Info< ManufacturerDecoder, ModelDecoder, SerialNumberDecoder, FirmwareVersionDecoder, VendorDecoder >, OpenSphericalCamera.Error > > {
        return Flow< Void, Never >()
            .apiQuery(
                provider: self.provider,
                dispatch: .main,
                request: { _ in
                    return OpenSphericalCamera.Query.Info.Request()
                },
                response: { _ in
                    return OpenSphericalCamera.Query.Info.Response< ManufacturerDecoder, ModelDecoder, SerialNumberDecoder, FirmwareVersionDecoder, VendorDecoder >()
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
