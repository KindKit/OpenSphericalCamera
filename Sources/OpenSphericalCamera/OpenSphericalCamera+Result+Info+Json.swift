//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Result.Info {
    
    struct JsonDecoder : IJsonModelDecoder {
        
        static func decode(
            _ json: Json
        ) throws -> OpenSphericalCamera.Result.Info<
            ManufacturerDecoder,
            ModelDecoder,
            SerialNumberDecoder,
            FirmwareVersionDecoder,
            VendorDecoder
        > {
            return .init(
                manufacturer: try json.decode(ManufacturerDecoder.self, path: "manufacturer"),
                model: try json.decode(ModelDecoder.self, path: "model"),
                serialNumber: try json.decode(SerialNumberDecoder.self, path: "serialNumber"),
                firmwareVersion: try json.decode(FirmwareVersionDecoder.self, path: "firmwareVersion"),
                supportUrl: try json.decode(URL.self, path: "supportUrl"),
                gps: try json.decode(Bool.self, path: "gps"),
                gyro: try json.decode(Bool.self, path: "gyro"),
                uptime: try json.decode(TimeInterval.self, path: "uptime"),
                apiLevels: json.decode(OpenSphericalCamera.ApiLevel.JsonDecoder.self, path: "apiLevels", default: [ .v1 ], skipping: true),
                vendor: try json.decode(VendorDecoder.self)
            )
        }
        
    }
    
}
