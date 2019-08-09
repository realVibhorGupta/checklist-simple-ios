//
//  ChecklistItem.swift
//  CheckListApp
//
//  Created by Vibhor Gupta on 2/26/19.
//  Copyright © 2019 Vibhor Gupta. All rights reserved.
//

import Foundation

class CheckListItem  : NSObject {

    var text = ""
    var checked = false


    func toggleCheckMark(){
        checked = !checked
    }

}
