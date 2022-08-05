//
// OpenSphericalCamera
//

import Foundation
import KindKitJson

public extension OpenSphericalCamera.Result {
    
    struct Info<
        ManufacturerDecoder : IJsonValueDecoder,
        ModelDecoder : IJsonValueDecoder,
        SerialNumberDecoder : IJsonValueDecoder,
        FirmwareVersionDecoder : IJsonValueDecoder,
        VendorDecoder : IJsonModelDecoder
    > {
        
        public let manufacturer: ManufacturerDecoder.Value
        public let model: ModelDecoder.Value
        public let serialNumber: SerialNumberDecoder.Value
        public let firmwareVersion: FirmwareVersionDecoder.Value
        public let supportUrl: URL
        public let gps: Bool
        public let gyro: Bool
        public let uptime: TimeInterval
        public let vendor: VendorDecoder.Model
        
    }
    
}
