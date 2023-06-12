//
//  Movie.swift
//  Tanerflix
//
//  Created by Taner Kaya on 18.04.2023.
//

import Foundation


struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    
    //Buradaki isimlerden birini JSON'u cektigin yerdeki isimle farkli yazarsan karsisindaki degeri nil atiyor.
    //Ornegin overview'i overvier yazdin diyelim, normalde string atamasi gereken degeri nil atiyor.
    //O yuzden isimlerin birebir olmasi cok onemli.
    let id: Int
    let media_type: String?
    let original_name : String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}



