import UIKit
import Combine

class DetailViewController: UIViewController {
  
  private lazy var contentView = DetailView()
  private let vm: DetailViewModel
  private var subscriptions = Set<AnyCancellable>()
    
  init(gifID: String) {
    self.vm = DetailViewModel(gifID: gifID)
    super.init(nibName: nil, bundle: nil)
  }

  override func loadView() {
    view = contentView
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setUpBindings()
    Task {
      await vm.fetch()
    }
  }
    
  private func setUpBindings() {
    vm.$detailGif
      .receive(on: DispatchQueue.main)
      .sink { [weak self] item in
        guard let item = item else { return }
        self?.contentView.setGif(gif: item)
      }
      .store(in: &subscriptions)
  }
}
