/**
 Object conforming to the `Error` `protocol`
 
 Used by an App to interpret unsuccessful service calls
 */
public struct ServiceCallError: Error {
    /// A meaningful message detailing the error's root cause
    public let message: String
    /// The error's accompanying `HTTPStatusCode`, if one was returned from service
    public let code: Int?
    
    /**
     Public initializer of a `ServiceCallError` object
          
     - Parameters:
        - message: A meaningful message detailing the error's root cause
        - code: The error's accompanying `HTTPStatusCode`, if one was returned from service
     */
    public init(message: String, code: Int?) {
        self.message = message
        self.code = code
    }
}
