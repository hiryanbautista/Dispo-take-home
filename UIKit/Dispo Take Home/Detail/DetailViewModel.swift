import Foundation

final class DetailViewModel {
    
  @Published private(set) var detailGif: GifObject?
    
  private let service: GiphyService = GiphyService()
    
  let gifID: String
    
  init(gifID: String) {
    self.gifID = gifID
  }
    
  func fetch() async {
    do {
      let byID = try await service.fetchById(id: gifID)
      self.detailGif = byID.data
    } catch {
      // error
    }
  }
}
