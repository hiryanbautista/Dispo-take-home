import UIKit
import Combine

class MainViewController: UIViewController {
  
  private let vm = MainViewModel()
  private var subscriptions = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.titleView = searchBar
    setUpBindings()
    Task {
        await vm.fetch()
    }
  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "search gifs..."
    searchBar.delegate = self
    return searchBar
  }()

  private var layout: UICollectionViewLayout = {
    // TODO: implement
    let l = UICollectionViewFlowLayout()
    l.minimumLineSpacing = 0
    l.minimumInteritemSpacing = 0
    return l
  }()

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    collectionView.backgroundColor = .clear
    collectionView.keyboardDismissMode = .onDrag
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: "MainViewCell")
    return collectionView
  }()
  
  private func setUpBindings() {
    vm.$trending
      .receive(on: DispatchQueue.main)
      .sink { [weak self] items in
        self?.collectionView.reloadData()
      }
      .store(in: &subscriptions)
      
    vm.$isSearching
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.collectionView.reloadData()
      }
      .store(in: &subscriptions)
  }
}

// MARK: UICollectionViewDatasource
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return vm.isSearching ? vm.searchResults.count : vm.trending.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewCell", for: indexPath) as! MainViewCell
    let items = vm.isSearching ? vm.searchResults : vm.trending
    cell.configureCell(gif: items[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let items = vm.isSearching ? vm.searchResults : vm.trending
    let detailViewController = DetailViewController(gifID: items[indexPath.row].id)
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}


// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // TODO: implement
    guard let text = searchBar.text else { return }
    if text.isEmpty {
        vm.isSearching = false
        return
    }
    Task {
        await vm.fetchQuery(query: text)
        vm.isSearching = true
    }
  }
}
