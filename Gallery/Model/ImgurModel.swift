//
//  ImgurModel.swift
//  Gallery
//
//  Created by claudiocarvalho on 21/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation

struct ImgurModelData: Codable {
    let data: [ImgurModel]?
}

struct ImgurModel: Codable {
    let id, title: String?
    let imgurModelDescription: String?
    let datetime: Int?
    let cover: String?
    let coverWidth, coverHeight: Int?
    let accountURL: String?
    let accountID: Int?
    let privacy, layout: String?
    let views: Int?
    let link: String?
    let ups, downs, points, score: Int?
    let isAlbum: Bool?
    let vote: String?
    let favorite, nsfw: Bool?
    let section: String?
    let commentCount, favoriteCount: Int?
    let topic: String?
    let topicID, imagesCount: Int?
    let inGallery, isAd: Bool?
    let adType: Int?
    let adURL: String?
    let inMostViral, includeAlbumAds: Bool?
    let images: [ImageApi]?

    enum CodingKeys: String, CodingKey {
        case id, title
        case imgurModelDescription = "description"
        case datetime
        case cover
        case coverWidth = "cover_width"
        case coverHeight = "cover_height"
        case accountURL = "account_url"
        case accountID = "account_id"
        case privacy, layout, views, link, ups, downs, points, score
        case isAlbum = "is_album"
        case vote, favorite, nsfw, section
        case commentCount = "comment_count"
        case favoriteCount = "favorite_count"
        case topic
        case topicID = "topic_id"
        case imagesCount = "images_count"
        case inGallery = "in_gallery"
        case isAd = "is_ad"
        case adType = "ad_type"
        case adURL = "ad_url"
        case inMostViral = "in_most_viral"
        case includeAlbumAds = "include_album_ads"
        case images
    }
}

