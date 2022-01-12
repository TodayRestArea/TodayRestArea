
import UIKit
import SnapKit

class ContentCell: UICollectionViewCell {
    
    var backImage : UIImageView = {
        let tmp = UIImage(named: "movie")
        let temp = UIImageView(image: tmp)
        temp.contentMode = .scaleAspectFit
        return temp
    }()
    
    var titlestr: UILabel = {
        let temp = UILabel()
        temp.text = "퐁네프의 연인들"
        temp.textColor = .white
        temp.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        temp.font = UIFont(name: "SANGJU-Gotgam", size: 18)
        temp.numberOfLines = 0
        temp.textAlignment = .center
        return temp;
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(backImage)
        backImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        self.addSubview(titlestr)
        titlestr.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(8)
            $0.centerX.equalTo(backImage.snp.centerX)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    
    
    
    
    
    
}
