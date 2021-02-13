//
//  MainPageData.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 31/01/2021.
//

import Foundation


struct Sport_Info: Hashable, Codable {
    var sport_name: String
    var image_name: String
}

var sports: [Sport_Info] = load("AppData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
