//
//  Errors.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import Foundation

enum ErrorKey: String {
    case general = "Error_general"
    case parsing = "Error_parsing"
}

class ErrorModel: Error {

    var messageKey: String
    var message: String {
        return messageKey
    }

    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
    
}

extension ErrorModel {

    static func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }

}


