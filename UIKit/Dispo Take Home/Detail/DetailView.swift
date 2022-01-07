import UIKit
import Kingfisher

final class DetailView: UIView {
    
  lazy var gifImageView = UIImageView()
  lazy var titleLabel: UILabel = {
    let l = UILabel()
    l.numberOfLines = 0
    l.textAlignment = .center
    return l
  }()
  lazy var usernameLabel: UILabel = {
    let l = UILabel()
    l.textAlignment = .center
    return l
  }()
  lazy var sourceLabel: UILabel = {
    let l = UILabel()
    l.textAlignment = .center
    return l
  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
      
    addSubview(gifImageView)
    gifImageView.snp.makeConstraints {
      $0.center.equalTo(self)
    }
        
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerX.equalTo(self)
      $0.top.equalTo(gifImageView.snp.bottom).offset(12)
      $0.leading.equalTo(12)
      $0.trailing.equalTo(self.snp.trailing).offset(-12)
    }
        
    addSubview(usernameLabel)
    usernameLabel.snp.makeConstraints {
      $0.centerX.equalTo(self)
      $0.top.equalTo(titleLabel.snp.bottom).offset(12)
    }
    
    addSubview(sourceLabel)
    sourceLabel.snp.makeConstraints {
      $0.centerX.equalTo(self)
      $0.top.equalTo(usernameLabel.snp.bottom).offset(12)
    }
  }
    
  func setGif(gif: GifObject) {
    gifImageView.kf.setImage(with: gif.images.fixed_height.url)
    titleLabel.text = gif.title
    sourceLabel.text = gif.source_tld
    if let username = gif.username, !username.isEmpty {
      usernameLabel.text = "@\(username)"
    }
    
  }
    
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
