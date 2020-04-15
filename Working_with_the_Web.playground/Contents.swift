import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    init (from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        
        return components?.url
    }
}

func fetchPhotoInfo() ->PhotoInfo {
    let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!

    let query: [String: String] = [
        "api_key": "DEMO_KEY"
    ]

    let url = baseUrl.withQueries(query)!

    print(url.scheme ?? "nil")
    print(url.host ?? "nil")
    print(url.query ?? "nil")

    let task = URLSession.shared.dataTask(with: url) { (data, url, error) in
        
        let jsonDecoder = JSONDecoder()
        
        if let data = data,
            let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
            print(photoInfo)

            return photoInfo
        }
    }
}

