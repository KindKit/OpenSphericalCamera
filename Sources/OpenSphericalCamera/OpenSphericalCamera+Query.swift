//
// OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitJson

extension OpenSphericalCamera {
    
    enum Query {
        
        class Response< Success > : IApiResponse {
            
            typealias Success = Success
            typealias Failure = OpenSphericalCamera.Error
            typealias Result = Swift.Result< Success, Failure >
            
            func parse(meta: KindKitApi.Api.Response.Meta, data: Data?) -> Result {
                if let data = data {
                    if let json = Json(data: data) {
                        do {
                            return .success(try self.parse(meta: meta, result: json))
                        } catch let error as Failure {
                            return .failure(error)
                        } catch {
                            do {
                                return .failure(try self.parse(error: json))
                            } catch let error as Failure {
                                return .failure(error)
                            } catch {
                                return .failure(.invalidResponse)
                            }
                        }
                    } else {
                        do {
                            return .success(try self.parse(meta: meta, result: data))
                        } catch let error as Failure {
                            return .failure(error)
                        } catch {
                            return .failure(.invalidResponse)
                        }
                    }
                } else {
                    return .failure(.invalidResponse)
                }
            }
            
            func parse(error: Swift.Error) -> Result {
                let nsError = error as NSError
                switch nsError.domain {
                case NSURLErrorDomain:
                    switch nsError.code {
                    case NSURLErrorUnknown: return .failure(.invalidRequest)
                    case NSURLErrorNotConnectedToInternet: return .failure(.notConnected)
                    case NSURLErrorNetworkConnectionLost: return .failure(.connectionLost)
                    case NSURLErrorTimedOut: return .failure(.timeOut)
                    default: return .failure(.invalidResponse)
                    }
                default: return .failure(.invalidResponse)
                }
            }
            
            func parse(meta: KindKitApi.Api.Response.Meta, result data: Data) throws -> Success {
                throw Failure.invalidResponse
            }

            func parse(meta: KindKitApi.Api.Response.Meta, result json: Json) throws -> Success {
                throw Failure.invalidResponse
            }
            
            func parse(error json: Json) throws -> Failure {
                let error = try json.decode(OpenSphericalCamera.Error.Internal.Decoder.self, path: "error")
                return .internal(error)
            }
            
        }
        
    }
    
}
