//
//  Request.swift
//  HHMACSwift
//
//  Created by Yannick Heinrich on 11.04.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import Foundation
import CryptoSwift

extension NSURLRequest {

    public var characteristic: String {
        get {

            guard
                let URL = URL,
                let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: true),
                let path = components.path,
                let host = components.host,
                let method = self.HTTPMethod
            else { return "" }


            var args = [method.lowercaseString, host]
            args.appendContentsOf(path.componentsSeparatedByString("/"))

            if let items = components.queryItems {

                let itemString = items.map({ "\($0.name)_\($0.value ?? "" )"})
                args.appendContentsOf(itemString)
            }

            return args.filter({ $0 != "" }).sort().joinWithSeparator("_")
        }
    }

    public func hash(date: NSDate, publicKey: String, secretKey: String, variant: HMAC.Variant) -> String {

        let args = [self.characteristic, "\(Int64(date.timeIntervalSince1970*1e9))", publicKey]
        let signRaw = args.joinWithSeparator("_")

        let key = secretKey.utf8.map({$0})
        let message = signRaw.utf8.map({$0})

        return try! Authenticator.HMAC(key: key, variant: variant).authenticate(message).toBase64()!
    }
}