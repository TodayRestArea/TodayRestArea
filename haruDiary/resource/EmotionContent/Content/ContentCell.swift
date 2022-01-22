
import UIKit
import SnapKit
import SafariServices

class recommendMovieCell: UICollectionViewCell {
    
    var movieInfo: RecommendMovieList!
    var delegate: tapMoreBtn?
    lazy var backImage : UIImageView = {
        let url = URL(string: self.movieInfo.posterUrl!)
        let data = try? Data(contentsOf: url!)
        let tmp = UIImage(data: data ?? Data())
        let temp = UIImageView(image: tmp)
        temp.contentMode = .scaleAspectFit
        return temp
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(backImage)
        backImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
      
    }

}


class recommendMusicCell: UICollectionViewCell {
    
    var musicInfo: RecommendMusicList?
    var delegate: tapMoreBtn?
    lazy var backImage : UIImageView = {
        let url = URL(string: self.musicInfo?.posterUrl! ?? "")
        let data = try? Data(contentsOf: url!)
        let tmp = UIImage(data: data ?? Data())
        let temp = UIImageView(image: tmp)
        temp.layer.opacity = 0.5
        temp.contentMode = .scaleAspectFit
        return temp
    }()
    
    lazy var titlestr: UILabel = {
        let temp = UILabel()
        temp.text = musicInfo?.title ?? "멀어"
        temp.textColor = .black
        temp.font = UIFont(name: "SANGJU-Gotgam", size: 18)
        temp.numberOfLines = 0
        temp.sizeToFit()
        temp.textAlignment = .center
        return temp;
    }()
    
    lazy var artiststr: UILabel = {
        let temp = UILabel()
        temp.text = musicInfo?.artist ?? "빈지노"
        temp.textColor = .black
        temp.font = UIFont(name: "SANGJU-Gotgam", size: 12)
        temp.numberOfLines = 0
        temp.sizeToFit()
        temp.textAlignment = .center
        return temp;
    }()
    
    lazy var moreTV: UIView = {
        let tv = UIView()
        let temp = UILabel()
        temp.text = "more"
        temp.tintColor = .black
        tv.addSubview(temp)
        temp.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        return tv
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(backImage)
        backImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        self.addSubview(titlestr)
        titlestr.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        self.addSubview(artiststr)
        artiststr.snp.makeConstraints{
            $0.top.equalTo(titlestr.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
        self.addSubview(moreTV)
        let g = UITapGestureRecognizer(target: self, action: #selector(tapMore(_:)))
        moreTV.addGestureRecognizer(g)
        moreTV.snp.makeConstraints{
            $0.trailing.top.equalToSuperview().inset(12)
            $0.width.equalTo(30)
            $0.height.equalTo(20)
        }
    }
    
    @objc func tapMore(_ sender : Any){
        let blogUrl = NSURL(string: (musicInfo?.infoUrl)!)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        delegate?.tap(v: blogSafariView)
    }
}

protocol tapMoreBtn {
    func tap(v : UIViewController)
}

