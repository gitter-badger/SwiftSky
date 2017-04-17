//
//  SwiftSky.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

/**
 Describes the failure that occured during the
 retrieval/processing of a `Forecast` from the Dark Sky API.
 
 ## Possible Errors
 ```
 ApiError.noApiKey
 ApiError.noDataRequested
 ApiError.serverError
 ApiError.invalidJSON(AFError?)
 
*/
public enum ApiError : Error {
    
    /**
     No API key was set on `SwiftSky`, like so:
     
     ```swift
     SwiftSky.key = "your_key_here"
     ```
     
     You can signup for an api key at:
     [https://darksky.net/dev/register](https://darksky.net/dev/register)
    */
    case noApiKey
    
    /**
     No `DataType`s are passed to `Swift.get()`.
     Since this would result in an empty `Forecast`. To save resources on both
     the client and api sides, the request will not be executed.
    */
    case noDataRequested
    
    /**
     The LocationConvertible provided to `Swift.get()` could not be converted to a `Location`
    */
    case invalidLocation
    
    /**
     A status code in the `500` range is returned
     when requesting a `Forecast` from the Dark Sky API servers.
    */
    case serverError
    
    /**
     Occurs when the JSON returned from the Dark Sky
     API servers cannot be proccessed into a `Forecast` object.
 
     Contains an optional `AFError` object from the underlying
     `Alamofire` request. Check the `ResponseSerializationFailureReason`
     of the error for more details on the failing serialization.
    */
    case invalidJSON(AFError?)

}

/**
 Represents the success or failure of the retrieval/processing
 of a `Forecast` object from the Dark Sky API.

 ## Possible Implementations
 __A Switch Statement (cleanest)__
 
 ```swift
 switch result {
 case .success(let forecast):
    // do something with the `Forecast`
 case .error(let error):
    // do something with `Error`
 }
 ```
 __A Conditional Statement__
 
 ```swift
 if let forecast = result.response as? Forecast {
    // do something with `Forecast`
 } else if let error = result.error as? ApiError {
    // do something with `Error`
 }
 ```
*/
public enum Result {
    
    /// `Forecast` retrieval/processing was succesful
    case success(Forecast)
    
    /// `Forecast` retrieval/processing has failed
    case failure(ApiError)
    
    /// `Forecast` value in case of success, nil otherwise
    public var response: (Forecast?) {
        switch self {
        case .success(let forecast):
            return (forecast)
        case .failure:
            return (nil)
        }
    }
    
    /// `ApiError` in case of failure, nil otherwise
    public var error: ApiError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
}

/// Specifier for the amount of desired hours in a `Forecast` object
public enum HourAmount {
    
    /// Represents `48` hours over 2 days (first two days in a `Forecast`)
    case fortyEight
    
    /// Represents `168` hours over 7 days (max amount of days in a `Forecast`)
    case hundredSixtyEight

}

/// Types adopting this protocol can be used to construct
/// a `Location` for `SwiftSky.get()` requests.
public protocol LocationConvertible {
    /// Converts the adopting type into a `Location`
    func asLocation() -> Location?
}

/// Represents a physical location defined by latitude and longitude degrees
public struct Location : LocationConvertible {
    
    /// Specifies the north–south position of a point on the Earth's surface
    public let latitude : Double
    
    /// Specifies the east–west position of a point on the Earth's surface
    public let longitude : Double
    
    /// :nodoc:
    public func asLocation() -> Location? {
        return self
    }
    
}

/// :nodoc:
extension String : LocationConvertible {
    public func asLocation() -> Location? {
        let split = self.components(separatedBy: ",")
        guard split.count == 2, let lat = Double(split.first!), let lon = Double(split.last!) else { return nil }
        return Location(latitude: lat, longitude: lon)
    }
}

/// :nodoc:
extension CLLocation : LocationConvertible {
    public func asLocation() -> Location? {
        return Location(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}

/// :nodoc:
extension CLLocationCoordinate2D : LocationConvertible {
    public func asLocation() -> Location? {
        return Location(latitude: self.latitude,longitude: self.longitude)
    }
}

/// Contains settings and returns `Forecast`'s
public struct SwiftSky {
    
    /**
     The Dark Sky secret key used when making requests to the Dark Sky Servers
     
     You can get a secret key by registering at:
     [https://darksky.net/dev/register](https://darksky.net/dev/register)
    */
    public static var key : String?
    
    /**
     The units that are used for the values in the
     `Forecast`'s `DataPoint` objects created by `SwiftSky.get()`
     
     __Note:__ 
     All values have conversion functions available
    */
    public static var units : UnitProfile = UnitProfile()
    
    /**
     The language that is used for the summaries in the 
     `Forecast` objects generated by `SwiftSky.get()`
    */
    public static var language : Language = Language.userPreference
    
    /// Used to determine decimal delimiter, defaults to user's current locale
    public static var locale : Locale = Locale.current
    
    /// The desired amount of hours to be present in a `Forecast` (48 default)
    public static var hourAmount : HourAmount = .fortyEight
    
    /**
     Used to get a `Forecast` from the Dark Sky Servers
     
     __Example Request__
     
     ```swift
     SwiftSky.get([.current,.minutes,.hours,.days],
        at: Location(latitude: 0.0, longitude: 0.0)
     ) { result in
         switch result {
         case .success(let forecast):
             // do something with forecast
         case .failure(let error):
             // handle error
         }
     }
     ```
     
     - parameter data: array of `DataType`'s that are desired to be present
     - parameter at: a `LocationConvertible` to return a `Forecast` for
     - parameter on: an optional `Date` to return the `Forecast` for
     - parameter completion: a completion block returning a `Result`
     - returns: a `Result` in a completion block
    */
    public static func get(
        _  data         : [DataType],
        at location     : LocationConvertible,
        on date         : Date? = nil,
        _  completion   : @escaping (Result) -> Void
    ) {
        
        // check if location is valid
        guard let located = location.asLocation()
        else { return(completion(.failure(.invalidLocation))) }
        
        // check if Dark Sky secret key is set
        guard SwiftSky.key != nil
        else { return(completion(.failure(.noApiKey))) }
        
        // check if ANY data is requested
        guard !data.isEmpty
        else { return(completion(.failure(.noDataRequested))) }
        
        // construct exclude list from include list
        var exclude : [DataType] = [.current,.minutes,.hours,.days,.alerts]
        for type in data {
            if let index = exclude.index(of: type) {
                exclude.remove(at: index)
            }
        }
        
        // get api url
        let url = ApiUrl(located, date: date, exclude: exclude).url
        
        // perform request
        request(url, method: .get, headers: ["Accept-Encoding":"gzip"]).responseJSON { response in
            switch response.result {
            case .success(let data):
                completion(.success(Forecast(data, headers: response.response?.allHeaderFields)))
            case .failure(let error):
                let code = response.response?.statusCode ?? 404
                if code >= 500 && code < 600 {
                    completion(.failure(.serverError))
                } else {
                    completion(.failure(.invalidJSON(error as? AFError)))
                }
            }
        }
        
    }
    
}
