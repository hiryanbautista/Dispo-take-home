import Foundation

enum GiphyAPI: NetworkAPI {
    
    case trending
    case search(query: String)
    case byId(id: String)
    
    var baseURL: String {
        return "https://api.giphy.com/v1/gifs"
    }
    
    var path: String {
        switch self {
        case .trending:
            return "/trending"
        case .search:
            return "/search"
        case .byId(let id):
            return "/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var query: [String : String]? {
        var q: [String: String] = [
            "api_key": GiphyAPIConstants.apiKey
        ]
        switch self {
        case .trending:
            q["limit"] = "25"
            q["rating"] = "pg"
            return q
        case .search(let query):
            q["q"] = query
            q["limit"] = "25"
            q["offset"] = "0"
            q["rating"] = "pg"
            q["lang"] = "en"
        case .byId:
            break
        }
        return q
    }
    
    var request: URLRequest {
        var urlComponents = URLComponents(string: baseURL + path)!
        
        if let query = query {
            urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        if let body = body {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
        return request
    }
}
