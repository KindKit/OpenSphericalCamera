//
// OpenSphericalCamera
//

import Foundation
import KindKitCore
import KindKitJson

extension OpenSphericalCamera.Result.Command {
    
    struct JsonDecoder : IJsonModelDecoder {
        
        static func decode(
            _ json: Json
        ) throws -> OpenSphericalCamera.Result.Command<
            ResultDecoder
        > {
            return .init(
                state: try json.decode(OpenSphericalCamera.State.JsonDecoder.self, path: "state"),
                id: try? json.decode(String.self, path: "id"),
                progress: try? json.decode(Float.self, path: "progress.completion"),
                result: try? json.decode(ResultDecoder.self, path: "results")
            )
        }
        
    }
    
}
