import Foundation

@MainActor
final class GiphyViewModel: ObservableObject {
    
    @Published private(set) var trending: [GifObject] = []
    @Published private(set) var gifDetail: GifObject?
    @Published var searchQuery: String = ""
    @Published private(set) var searchResults: [GifObject] = []
    
    private let service: GiphyService
    
    init() {
        self.service = GiphyService()
    }
    
    func fetch() async {
        do {
            let trending = try await service.fetchTrending()
            self.trending = trending.data
        } catch {
            // error
        }
    }
    
    func fetchById(id: String) async {
        do {
            let detail = try await service.fetchById(id: id)
            self.gifDetail = detail.data
        } catch {
            // error
        }
    }
    
    func fetchQuery() async {
        do {
            let query = try await service.fetchQuery(query: self.searchQuery)
            self.searchResults = query.data
        } catch {
            // error
        }
    }
    
    func removeDetail() {
        self.gifDetail = nil
    }
    
}
