//
// OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera {
    
    struct Info<
        ManufacturerDecoder : IJsonValueDecoder,
        ModelDecoder : IJsonValueDecoder,
        SerialNumberDecoder : IJsonValueDecoder,
        FirmwareVersionDecoder : IJsonValueDecoder,
        SpecificDecoder : IJsonModelDecoder
    > {
        
        public let manufacturer: ManufacturerDecoder.JsonDecoded
        public let model: ModelDecoder.JsonDecoded
        public let serialNumber: SerialNumberDecoder.JsonDecoded
        public let firmwareVersion: FirmwareVersionDecoder.JsonDecoded
        public let supportUrl: URL
        public let gps: Bool
        public let gyro: Bool
        public let uptime: TimeInterval
        public let versions: [OpenSphericalCamera.Version]
        public let specific: SpecificDecoder.JsonModelDecoded
        
    }
    
}

extension OpenSphericalCamera.Info : IJsonModelDecoder {
    
    public static func decode(_ json: Json) throws -> Self {
        return .init(
            manufacturer: try json.decode(ManufacturerDecoder.self, path: [ "manufacturer" ]),
            model: try json.decode(ModelDecoder.self, path: [ "model" ]),
            serialNumber: try json.decode(SerialNumberDecoder.self, path: [ "serialNumber" ]),
            firmwareVersion: try json.decode(FirmwareVersionDecoder.self, path: [ "firmwareVersion" ]),
            supportUrl: try json.decode(URL.self, path: [ "supportUrl" ]),
            gps: try json.decode(Bool.self, path: [ "gps" ]),
            gyro: try json.decode(Bool.self, path: [ "gyro" ]),
            uptime: try json.decode(TimeInterval.self, path: [ "uptime" ]),
            versions: try json.decode(OpenSphericalCamera.Version.self, path: [ "apiLevel" ], skipping: false),
            specific: try json.decode(SpecificDecoder.self)
        )
    }
    
}

