//
//  Contact.swift
//  Contact
//
//  Created by Nikolay Zhukov on 11.07.2023.
//

import Foundation

protocol ContactProtocol {
    var title: String { get set } // name
    var phone: String { get set } // number
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}
