//
// OpenSphericalCamera
//

import Foundation
import KindKit

public extension OpenSphericalCamera {
    
    enum Query {
        
        public class Response< Success > : IApiResponse {
            
            public typealias Success = Success
            public typealias Failure = OpenSphericalCamera.Error
            public typealias Result = Swift.Result< Success, Failure >
            
            public init() {
            }
            
            public func parse(meta: Api.Response.Meta, data: Data?) -> Result {
                switch meta.statusCode {
                case 503: return .failure(.busy)
                default: break
                }
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
            
            public func parse(error: Swift.Error) -> Result {
                let nsError = error as NSError
                switch nsError.domain {
                case NSURLErrorDomain:
                    switch nsError.code {
                    case NSURLErrorUnknown: return .failure(.invalidRequest)
                    case NSURLErrorNotConnectedToInternet: return .failure(.noConnection)
                    case NSURLErrorNetworkConnectionLost: return .failure(.connectionLost)
                    case NSURLErrorTimedOut: return .failure(.timeOut)
                    default: return .failure(.invalidResponse)
                    }
                default: return .failure(.invalidResponse)
                }
            }
            
            func parse(meta: Api.Response.Meta, result data: Data) throws -> Success {
                throw Failure.invalidResponse
            }

            func parse(meta: Api.Response.Meta, result json: Json) throws -> Success {
                throw Failure.invalidResponse
            }
            
            func parse(error json: Json) throws -> Failure {
                return .detail(try json.decode(OpenSphericalCamera.Error.Detail.self, path: "error"))
            }
            
        }
        
    }
    
}
