import Foundation

final class MainViewModel {
    
  @Published private(set) var trending: [GifObject] = []
  @Published private(set) var searchResults: [GifObject] = []
  @Published var isSearching = false
    
  private let service: GiphyService = GiphyService()
    
  func fetch() async {
    do {
      let trending = try await service.fetchTrending()
      self.trending = trending.data
    } catch {
      // error
    }
  }
    
  func fetchQuery(query: String) async {
    do {
      let search = try await service.fetchQuery(query: query)
      self.searchResults = search.data
    } catch {
      // error
    }
  }
}
