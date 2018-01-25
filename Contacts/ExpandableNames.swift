//
//  ExpandableNames.swift
//  Contacts
//
//  Created by John Nik on 11/25/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import Foundation

struct ExpandableNames {
    
    var isExpanded: Bool
    var names: [Contact]
    
}

struct Contact {
    let name: String
    var hasFavorited: Bool
}
