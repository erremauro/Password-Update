//
//  ConsoleLogger.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/23/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import Foundation
import os

class ConsoleLogger {
    static let shared = ConsoleLogger()
    
    struct LogType {
        static let `default` = OSLog(subsystem: Utils.getBundleId(), category: "password update")
        static let validation = OSLog(subsystem: Utils.getBundleId(), category: "validation")
        static let keychain = OSLog(subsystem: Utils.getBundleId(), category: "keychain")
    }
    
    func log(_ message: String, logger: OSLog? = LogType.default) {
        os_log("%{public}@", log: logger!, type: .default, message)
    }
    
    func logInfo(_ message: String, logger: OSLog? = LogType.default) {
        os_log("%{public}@", log: logger!, type: .info, message)
    }
    
    func logError(_ message: String, logger: OSLog? = LogType.default) {
        os_log("%{public}@", log: logger!, type: .error, message)
    }
    
    func logFault(_ message: String, logger: OSLog? = LogType.default) {
        os_log("%{public}@", log: logger!, type: .fault, message)
    }
}
