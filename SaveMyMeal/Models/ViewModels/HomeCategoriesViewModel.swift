//
//  HomeCategoriesViewModel.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/25/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
class HomeCategoriesViewModel {
    var id: Int = 0
    var title: String = ""
    var selected: Bool = false
    init(data: HomeCategory) {
        self.id = data.id ?? 0
        self.title = data.name ?? ""
        
    }
}
