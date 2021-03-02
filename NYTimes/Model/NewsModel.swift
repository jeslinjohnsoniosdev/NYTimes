//
//  NewsModel.swift
//  NYTimes
//
//  Created by Jeslin Johnson on 01/03/2021.
//  Copyright © 2021 Jeslin Johnson. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class NewsModel: Codable {

    var news: NewsResultModel?

    init(model: NewsResultModel? = nil) {
        if let inputModel = model {
            self.news = inputModel
        }
    }
}

class NewsResultModel: Codable {
    let status, copyright: String?
    let numResults: Int?
    var results: [Result]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }

    init(status: String?, copyright: String?, numResults: Int?, results: [Result]?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }

}

extension NewsResultModel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NewsResultModel.self, from: data)
        self.init(status: me.status, copyright: me.copyright, numResults: me.numResults, results: me.results)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        status: String?? = nil,
        copyright: String?? = nil,
        numResults: Int?? = nil,
        results: [Result]?? = nil
    ) -> NewsResultModel {
        return NewsResultModel(
            status: status ?? self.status,
            copyright: copyright ?? self.copyright,
            numResults: numResults ?? self.numResults,
            results: results ?? self.results
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension NewsModel {
    func fetchNews(section: String, period: String, completion: @escaping (NewsResultModel?, AFError?) -> ()) {
        let urlPath = mostViewedURLPath + "/\(period)"
        guard let request = networkRequest(with: urlPath, queryParams: nil, bodyParams: nil, method: .get) else {
            return
        }
        AF.request(request).responseDecodable(of: NewsResultModel.self, queue: .main) { (newsResultModel) in
            completion(newsResultModel.value, newsResultModel.error)
        }
    }
}

class Result: Codable {
    let uri: String?
    let url: String?
    let id, assetID: Int?
    let source: Source?
    let publishedDate, updated, section: String?
    let subsection: Subsection?
    let nytdsection, adxKeywords: String?
    let column: JSONNull?
    let byline: String?
    let type: ResultType?
    let title, abstract: String?
    let desFacet, orgFacet, perFacet, geoFacet: [String]?
    let media: [Media]?
    let etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }

    init(uri: String?, url: String?, id: Int?, assetID: Int?, source: Source?, publishedDate: String?, updated: String?, section: String?, subsection: Subsection?, nytdsection: String?, adxKeywords: String?, column: JSONNull?, byline: String?, type: ResultType?, title: String?, abstract: String?, desFacet: [String]?, orgFacet: [String]?, perFacet: [String]?, geoFacet: [String]?, media: [Media]?, etaID: Int?) {
        self.uri = uri
        self.url = url
        self.id = id
        self.assetID = assetID
        self.source = source
        self.publishedDate = publishedDate
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.column = column
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaID = etaID
    }
}

// MARK: Result convenience initializers and mutators

extension Result {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Result.self, from: data)
        self.init(uri: me.uri, url: me.url, id: me.id, assetID: me.assetID, source: me.source, publishedDate: me.publishedDate, updated: me.updated, section: me.section, subsection: me.subsection, nytdsection: me.nytdsection, adxKeywords: me.adxKeywords, column: me.column, byline: me.byline, type: me.type, title: me.title, abstract: me.abstract, desFacet: me.desFacet, orgFacet: me.orgFacet, perFacet: me.perFacet, geoFacet: me.geoFacet, media: me.media, etaID: me.etaID)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        uri: String?? = nil,
        url: String?? = nil,
        id: Int?? = nil,
        assetID: Int?? = nil,
        source: Source?? = nil,
        publishedDate: String?? = nil,
        updated: String?? = nil,
        section: String?? = nil,
        subsection: Subsection?? = nil,
        nytdsection: String?? = nil,
        adxKeywords: String?? = nil,
        column: JSONNull?? = nil,
        byline: String?? = nil,
        type: ResultType?? = nil,
        title: String?? = nil,
        abstract: String?? = nil,
        desFacet: [String]?? = nil,
        orgFacet: [String]?? = nil,
        perFacet: [String]?? = nil,
        geoFacet: [String]?? = nil,
        media: [Media]?? = nil,
        etaID: Int?? = nil
    ) -> Result {
        return Result(
            uri: uri ?? self.uri,
            url: url ?? self.url,
            id: id ?? self.id,
            assetID: assetID ?? self.assetID,
            source: source ?? self.source,
            publishedDate: publishedDate ?? self.publishedDate,
            updated: updated ?? self.updated,
            section: section ?? self.section,
            subsection: subsection ?? self.subsection,
            nytdsection: nytdsection ?? self.nytdsection,
            adxKeywords: adxKeywords ?? self.adxKeywords,
            column: column ?? self.column,
            byline: byline ?? self.byline,
            type: type ?? self.type,
            title: title ?? self.title,
            abstract: abstract ?? self.abstract,
            desFacet: desFacet ?? self.desFacet,
            orgFacet: orgFacet ?? self.orgFacet,
            perFacet: perFacet ?? self.perFacet,
            geoFacet: geoFacet ?? self.geoFacet,
            media: media ?? self.media,
            etaID: etaID ?? self.etaID
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Media
class Media: Codable {
    let type: MediaType?
    let subtype: Subtype?
    let caption, copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }

    init(type: MediaType?, subtype: Subtype?, caption: String?, copyright: String?, approvedForSyndication: Int?, mediaMetadata: [MediaMetadatum]?) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
}

// MARK: Media convenience initializers and mutators

extension Media {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Media.self, from: data)
        self.init(type: me.type, subtype: me.subtype, caption: me.caption, copyright: me.copyright, approvedForSyndication: me.approvedForSyndication, mediaMetadata: me.mediaMetadata)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: MediaType?? = nil,
        subtype: Subtype?? = nil,
        caption: String?? = nil,
        copyright: String?? = nil,
        approvedForSyndication: Int?? = nil,
        mediaMetadata: [MediaMetadatum]?? = nil
    ) -> Media {
        return Media(
            type: type ?? self.type,
            subtype: subtype ?? self.subtype,
            caption: caption ?? self.caption,
            copyright: copyright ?? self.copyright,
            approvedForSyndication: approvedForSyndication ?? self.approvedForSyndication,
            mediaMetadata: mediaMetadata ?? self.mediaMetadata
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - MediaMetadatum
class MediaMetadatum: Codable {
    let url: String?
    let format: Format?
    let height, width: Int?

    init(url: String?, format: Format?, height: Int?, width: Int?) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}

// MARK: MediaMetadatum convenience initializers and mutators

extension MediaMetadatum {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MediaMetadatum.self, from: data)
        self.init(url: me.url, format: me.format, height: me.height, width: me.width)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        url: String?? = nil,
        format: Format?? = nil,
        height: Int?? = nil,
        width: Int?? = nil
    ) -> MediaMetadatum {
        return MediaMetadatum(
            url: url ?? self.url,
            format: format ?? self.format,
            height: height ?? self.height,
            width: width ?? self.width
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

enum Subtype: String, Codable {
    case photo = "photo"
}

enum MediaType: String, Codable {
    case image = "image"
}

enum Source: String, Codable {
    case newYorkTimes = "New York Times"
}

enum Subsection: String, Codable {
    case empty = ""
    case music = "Music"
    case politics = "Politics"
}

enum ResultType: String, Codable {
    case article = "Article"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
