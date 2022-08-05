//
// OpenSphericalCamera
//

import Foundation
import KindKitApi
import KindKitCore
import KindKitFlow
import KindKitJson

public extension OpenSphericalCamera {
    
    func command<
        ResultDecoder : IJsonModelDecoder
    >(
        name: String,
        success: @escaping (OpenSphericalCamera.Result.Command< ResultDecoder >) -> Void,
        failure: @escaping (OpenSphericalCamera.Error) -> Void
    ) -> ICancellable {
        return self.provider.send(
            request: try OpenSphericalCamera.Query.Command.Request(name: name),
            response: OpenSphericalCamera.Query.Command.ResultResponse< ResultDecoder >(),
            queue: .main,
            completed: { response in
                switch response {
                case .success(let result): success(result)
                case .failure(let error): failure(error)
                }
            }
        )
    }
    
    func command<
        ResultDecoder : IJsonModelDecoder
    >() -> Pipeline< Swift.Result< String, Never >, Swift.Result< OpenSphericalCamera.Result.Command< ResultDecoder >, OpenSphericalCamera.Error > > {
        return Flow< String, Never >()
            .apiQuery(
                provider: self.provider,
                dispatch: .main,
                request: { try OpenSphericalCamera.Query.Command.Request(name: $0) },
                response: { _ in OpenSphericalCamera.Query.Command.ResultResponse< ResultDecoder >() },
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

public extension OpenSphericalCamera {
    
    func command(
        name: String,
        success: @escaping (Data) -> Void,
        failure: @escaping (OpenSphericalCamera.Error) -> Void
    ) -> ICancellable {
        return self.provider.send(
            request: try OpenSphericalCamera.Query.Command.Request(name: name),
            response: OpenSphericalCamera.Query.Command.DirectResponse(),
            queue: .main,
            completed: { response in
                switch response {
                case .success(let result): success(result)
                case .failure(let error): failure(error)
                }
            }
        )
    }
    
    func command() -> Pipeline< Swift.Result< String, Never >, Swift.Result< Data, OpenSphericalCamera.Error > > {
        return Flow< String, Never >()
            .apiQuery(
                provider: self.provider,
                dispatch: .main,
                request: { try OpenSphericalCamera.Query.Command.Request(name: $0) },
                response: { _ in OpenSphericalCamera.Query.Command.DirectResponse() },
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

public extension OpenSphericalCamera {
    
    func command<
        ParametersEncoder : IJsonModelEncoder,
        ResultDecoder : IJsonModelDecoder
    >(
        name: String,
        encoder: ParametersEncoder.Type,
        parameters: ParametersEncoder.Model,
        success: @escaping (OpenSphericalCamera.Result.Command< ResultDecoder >) -> Void,
        failure: @escaping (OpenSphericalCamera.Error) -> Void
    ) -> ICancellable {
        return self.provider.send(
            request: try OpenSphericalCamera.Query.Command.Request(name: name, encoder: encoder, parameters: parameters),
            response: OpenSphericalCamera.Query.Command.ResultResponse< ResultDecoder >(),
            queue: .main,
            completed: { response in
                switch response {
                case .success(let result): success(result)
                case .failure(let error): failure(error)
                }
            }
        )
    }
    
    func command<
        ParametersEncoder : IJsonModelEncoder,
        ResultDecoder : IJsonModelDecoder
    >(
        encoder: ParametersEncoder.Type,
        parameters: ParametersEncoder.Model
    ) -> Pipeline< Swift.Result< String, Never >, Swift.Result< OpenSphericalCamera.Result.Command< ResultDecoder >, OpenSphericalCamera.Error > > {
        return Flow< String, Never >()
            .apiQuery(
                provider: self.provider,
                dispatch: .main,
                request: { try OpenSphericalCamera.Query.Command.Request(name: $0, encoder: encoder, parameters: parameters) },
                response: { _ in OpenSphericalCamera.Query.Command.ResultResponse< ResultDecoder >() },
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

public extension OpenSphericalCamera {
    
    func command<
        ParametersEncoder : IJsonModelEncoder
    >(
        name: String,
        encoder: ParametersEncoder.Type,
        parameters: ParametersEncoder.Model,
        success: @escaping (Data) -> Void,
        failure: @escaping (OpenSphericalCamera.Error) -> Void
    ) -> ICancellable {
        return self.provider.send(
            request: try OpenSphericalCamera.Query.Command.Request(name: name, encoder: encoder, parameters: parameters),
            response: OpenSphericalCamera.Query.Command.DirectResponse(),
            queue: .main,
            completed: { response in
                switch response {
                case .success(let result): success(result)
                case .failure(let error): failure(error)
                }
            }
        )
    }
    
    func command<
        ParametersEncoder : IJsonModelEncoder
    >(
        encoder: ParametersEncoder.Type,
        parameters: ParametersEncoder.Model
    ) -> Pipeline< Swift.Result< String, Never >, Swift.Result< Data, OpenSphericalCamera.Error > > {
        return Flow< String, Never >()
            .apiQuery(
                provider: self.provider,
                dispatch: .main,
                request: { try OpenSphericalCamera.Query.Command.Request(name: $0, encoder: encoder, parameters: parameters) },
                response: { _ in OpenSphericalCamera.Query.Command.DirectResponse() },
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
