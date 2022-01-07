import Foundation

protocol NetworkAPI {
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String]? { get }
  var body: [String: Any]? { get }
  var query: [String: String]? { get }
  var request: URLRequest { get }
}
