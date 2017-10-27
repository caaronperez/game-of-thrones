//
//  oMDBAPI.swift
//  GoT
//
//  Created by MCS Devices on 10/26/17.
//  Copyright © 2017 Mobile Consulting Solutions. All rights reserved.
//

import Foundation

final class oMDBAPI{
    
    static let APIKey = "6bfb4e66"
    static let endPoint = "http://www.omdbapi.com/?apikey=\(APIKey)&i="
    static let seasonEndpoint = "&season="

    // SERIE Endpoint Dictionary Keys
    static let title = "Title"
    static let year = "Year"
    static let rated = "Rated"
    static let released = "Released"
    static let runtime = "Runtime"
    static let genre = "Genre"
    static let director = "Director"
    static let writer = "Writer"
    static let actors = "Actors"
    static let plot = "Plot"
    static let language = "Language"
    static let country = "Country"
    static let awards = "Awards"
    static let poster = "Poster"
    static let ratings = "Ratings"
    static let ratingsSource = "Source"
    static let ratingsValue = "Value"
    static let metascore = "Metascore"
    static let imdbRating = "imdbRating"
    static let imdbVotes = "imdbVotes"
    static let imdbID = "imdbID"
    static let type = "Type"
    static let totalSeasons = "totalSeasons"
    
    // SEASON Endpoint Dictionary Keys
    static let seasonTitle = "Title"
    static let season = "Season"
    static let episodes = "Episodes"
    
    // CHAPTER Endpoint Dictionary Keys
    static let chapterTitle = "Title"
    static let epidose = "Episode"
    static let seriesID = "seriesID"
}

