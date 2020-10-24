//
//  Movie.swift
//  MovieInfo
//
//  Created by administrator on 2020. 10. 23..
//  Copyright © 2020. administrator. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}
struct Movie: Decodable, Identifiable{
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    
    let genres: [MovieGenre]?
    let videos: MovieVideoResponse?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
           return "n/a"
        }
        return "\(ratingText.count)/10"
    }
       
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
        return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }

    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
        return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
    
}

struct MovieGenre: Decodable {
    
    let name: String
}

struct MovieVideoResponse: Decodable {
    
    let results: [MovieVideo]
}
struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
