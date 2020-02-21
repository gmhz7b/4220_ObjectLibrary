import struct Foundation.Data
import struct Foundation.URL
import struct Foundation.URLRequest
import class Foundation.URLResponse
import class Foundation.URLSession
import class Foundation.HTTPURLResponse

/**
 Convenience `typealias` representing a `Result` type
 
 A `success` case will return `Data`
 
 A `failure` case will return a `ServiceCallError`
 */
public typealias ServiceCallResult = Result<Data, ServiceCallError>

/// Object to be created and utilized in the Pokédex App
public final class BaseServiceClient {
    /// Public initializer of a `BaseServiceClient` object requires `0` parameters
    public init() {}
    
    /**
     Attempts to retrieve `Data` from a specified `URL`
     
     - Parameters:
        - url: The `URL` from which `Data` should be retrieved
        - completion: Closure called once a response from the service is recieved,
        or the service call times out. Passes a `Result` type as an argument to be handled
        by the caller.     
     */
    public func get(from url: URL, completion: @escaping (ServiceCallResult) -> ()) {
        /**
         Create a `URLRequest` and set method/headers
         
         Note that `request.httpMethod` default is “GET”
         */
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        /// Create the `URLSession` and the task to perform
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            self?.responseHandler(data: data, response: response, error: error, completion: completion)
        }
        
        /// Start the task
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

extension BaseServiceClient {
    /// Private method to parse response from `URLSessionDataTask` and complete with something meaningful to the App
    private func responseHandler(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (ServiceCallResult) -> ()) {
        /// Check for errors
        if let error = error {
            let serviceCallError = ServiceCallError(message: error.localizedDescription, code: nil)
            completion(.failure(serviceCallError))
            return
        }
        
        /// Check whether or not the response *can* be parsed
        guard let httpResponse = response as? HTTPURLResponse else {
            let serviceCallError = ServiceCallError(message: "Could not parse HTTP response", code: nil)
            completion(.failure(serviceCallError))
            return
        }
        
        /// Check that the response code is in the success range (200s)
        guard 200 ... 299 ~= httpResponse.statusCode else {
            let message: String = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            let serviceCallError = ServiceCallError(message: message, code: httpResponse.statusCode)
            completion(.failure(serviceCallError))
            return
        }
        
        /// Check that data exists
        guard let data = data else {
            let serviceCallError = ServiceCallError(message: "No Data", code: nil)
            completion(.failure(serviceCallError))
            return
        }
        
        /// Everything checks out! Completes with `Data`
        completion(.success(data))
    }
}
