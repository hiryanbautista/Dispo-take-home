import Foundation

final class GiphyService {
    
    private let urlSession = URLSession.shared
    
    func fetchTrending() async throws -> APIListResponse {
        let trending = GiphyAPI.trending
        let (data, _) = try await urlSession.data(for: trending.request)
        let trendingResponse = try JSONDecoder().decode(APIListResponse.self, from: data)
        return trendingResponse
    }
    
    func fetchById(id: String) async throws -> APISingleResponse {
        let byId = GiphyAPI.byId(id: id)
        let (data, _) = try await urlSession.data(for: byId.request)
        let byIdResponse = try JSONDecoder().decode(APISingleResponse.self, from: data)
        return byIdResponse
    }
    
    func fetchQuery(query: String) async throws -> APIListResponse {
        let search = GiphyAPI.search(query: query)
        let (data, _) = try await urlSession.data(for: search.request)
        let searchResponse = try JSONDecoder().decode(APIListResponse.self, from: data)
        return searchResponse
    }
}
