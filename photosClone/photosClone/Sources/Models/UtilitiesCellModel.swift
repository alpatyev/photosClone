//
//  UtilitiesCellModel.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/30/23.
//

struct UtilitiesModel {
    let image: String
    let title: String
    let itemsCountTitle: String
    let hasBottomDivider: Bool
    init(image: String = "default",
         title: String = "",
         count: Int = 0,
         divider: Bool = true) {
        self.image = image
        self.title = title
        itemsCountTitle = "\(count)"
        hasBottomDivider = divider
    }
}
