//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

public extension OpenSphericalCamera {
    
    final class Session<
        ManufacturerDecoder : IJsonValueDecoder,
        ModelDecoder : IJsonValueDecoder,
        SerialNumberDecoder : IJsonValueDecoder,
        FirmwareVersionDecoder : IJsonValueDecoder,
        InfoVendorDecoder : IJsonModelDecoder,
        StateVendorDecoder : IJsonModelDecoder
    > {
        
        public typealias Info = OpenSphericalCamera.Result.Info< ManufacturerDecoder, ModelDecoder, SerialNumberDecoder, FirmwareVersionDecoder, InfoVendorDecoder >
        public typealias State = OpenSphericalCamera.Result.State< StateVendorDecoder >
        
        public let camera: OpenSphericalCamera
        public private(set) var info: Info?
        public private(set) var state: State?
        public private(set) var error: OpenSphericalCamera.Error?
        public var isRefreshing: Bool {
            return self._query != nil
        }
        
        public let onRefresh: () -> Void
        public let onError: (OpenSphericalCamera.Error) -> Void
        
        private var _query: ICancellable?
        
        public init(
            _ camera: OpenSphericalCamera,
            onRefresh: @escaping () -> Void,
            onError: @escaping (OpenSphericalCamera.Error) -> Void
        ) {
            self.camera = camera
            self.onRefresh = onRefresh
            self.onError = onError
        }
        
        deinit {
            self.cancel()
        }
        
    }
    
}

public extension OpenSphericalCamera.Session {
    
    func refresh() {
        guard self.isRefreshing == false else { return }
        if self.info == nil {
            self._info()
        } else {
            self._state()
        }
    }
    
    func cancel() {
        self._query?.cancel()
        self._query = nil
    }
    
}

private extension OpenSphericalCamera.Session {
    
    func _info() {
        self._query = self.camera.info(
            manufacturer: ManufacturerDecoder.self,
            model: ModelDecoder.self,
            serialNumber: SerialNumberDecoder.self,
            firmwareVersion: FirmwareVersionDecoder.self,
            vendor: InfoVendorDecoder.self,
            success: { [unowned self] in self._info($0) },
            failure: { [unowned self] in self._info($0) }
        )
    }
    
    func _info(_ result: Info) {
        self.info = result
        self._state()
    }
    
    func _info(_ error: OpenSphericalCamera.Error) {
        self._query = nil
        self.error = error
        self.onError(error)
    }
    
    func _state() {
        self._query = self.camera.state(
            vendor: StateVendorDecoder.self,
            success: { [unowned self] in self._state($0) },
            failure: { [unowned self] in self._state($0) }
        )
    }
    
    func _state(_ result: State) {
        self._query = nil
        self.state = result
        self.onRefresh()
    }
    
    func _state(_ error: OpenSphericalCamera.Error) {
        self.error = error
        self.onError(error)
    }
    
}
