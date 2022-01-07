import UIKit
import Kingfisher

class MainViewCell: UICollectionViewCell {
  
  private lazy var titleLabel: UILabel = {
    let l = UILabel()
    l.numberOfLines = 0
    return l
  }()
  private lazy var gifImageView: UIImageView = {
    let imgV = UIImageView()
    imgV.contentMode = .scaleToFill
    return imgV
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(gifImageView)
    gifImageView.snp.makeConstraints {
      $0.leading.equalTo(12)
      $0.width.height.equalTo(85)
      $0.centerY.equalTo(self)
    }
    
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.leading.equalTo(gifImageView.snp.trailing).offset(12)
      $0.trailing.equalTo(self.snp.trailing).offset(-36)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell(gif: GifObject) {    
    titleLabel.text = gif.title
    gifImageView.kf.setImage(with: gif.images.fixed_height.url)
  }
}
