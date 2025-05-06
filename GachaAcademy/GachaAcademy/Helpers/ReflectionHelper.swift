//
//  ReflectionHelper.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 5/5/2025.
//

import Foundation

class ReflectionHelper {
    static func getClassNameFromType(_ type: Any.Type) -> String {
        return String(describing: type);
    }
    
    static func getTypeFromClassName(_ className: String) -> Any.Type? {
        if let classType = NSClassFromString(className) {
            return classType;
        }
        return nil;
    }
}
