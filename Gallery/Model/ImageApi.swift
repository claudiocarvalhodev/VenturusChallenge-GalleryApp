//
//  ImageApi.swift
//  Gallery
//
//  Created by claudiocarvalho on 21/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation

struct ImageApi: Codable {
    let id: String?
    let title: String?
    let imageDescription: String?
    let datetime: Int?
    let type: String?
    let animated: Bool?
    let width, height, size, views: Int?
    let bandwidth: Int?
    let favorite: Bool?
    let nsfw, section, accountURL, accountID: String?
    let isAd, inMostViral, hasSound: Bool?
    let adType: Int?
    let adURL, edited: String?
    let inGallery: Bool?
    let link: String?
    let commentCount, favoriteCount, ups, downs: String?
    let points, score: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageDescription = "description"
        case datetime, type, animated, width, height, size, views, bandwidth, favorite, nsfw, section
        case accountURL = "account_url"
        case accountID = "account_id"
        case isAd = "is_ad"
        case inMostViral = "in_most_viral"
        case hasSound = "has_sound"
        case adType = "ad_type"
        case adURL = "ad_url"
        case edited
        case inGallery = "in_gallery"
        case link
        case commentCount = "comment_count"
        case favoriteCount = "favorite_count"
        case ups, downs, points, score
    }
}
