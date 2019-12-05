//
//  MyData.swift
//  SampleCustomClassDataStorage
//
//  Created by harapeko on 2019/12/05.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import Foundation

class MyData: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }

    var valueString: String?
    
    override init() {
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(valueString, forKey: "valueString")
    }

    required init?(coder: NSCoder) {
        valueString = coder.decodeObject(forKey: "valueString") as? String
    }
}
