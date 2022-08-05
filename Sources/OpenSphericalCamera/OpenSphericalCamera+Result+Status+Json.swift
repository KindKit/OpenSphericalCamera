//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Result.Status {
    
    struct JsonDecoder : IJsonModelDecoder {
        
        static func decode(
            _ json: Json
        ) throws -> OpenSphericalCamera.Result.Status<
            ResultDecoder
        > {
            return .init(
                state: try json.decode(OpenSphericalCamera.State.JsonDecoder.self, path: "state"),
                progress: try? json.decode(Float.self, path: "progress.completion"),
                result: try? json.decode(ResultDecoder.self, path: "results")
            )
        }
        
    }
    
}
