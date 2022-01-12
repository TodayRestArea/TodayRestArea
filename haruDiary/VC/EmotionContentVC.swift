
import UIKit

class EmotionContentVC: UIViewController {
    
    var titlestr = String()
    var date = Date()
    var emotions = "슬픔"
    
    lazy var todayEmotion: UILabel = { [weak self] in
        guard let self = self else {return UILabel()}
        let temp = UILabel()
        temp.text = date.formatted(date: .numeric, time: .omitted).compare(Date().formatted(date: .numeric, time: .omitted)) == .orderedSame ? "오늘의 감정" : "그날의 감정"
        temp.textAlignment = .left
        temp.sizeToFit()
        temp.font = UIFont(name: "SANGJU-Gotgam", size: 25)
        return temp
    }()
    lazy var  emotion: UILabel = { [weak self] in
        guard let self = self else {return UILabel()}
        let temp = UILabel()
        temp.text = "#" + self.emotions
        temp.textAlignment = .left
        temp.layer.cornerRadius = 100;
        temp.sizeToFit()
        temp.font = UIFont(name: "SANGJU-Gotgam", size: 18)
        return temp;
    }()
    
    lazy var moviewHeader : UILabel = { [weak self] in
        guard let self = self else {return UILabel()}
        let temp = UILabel()
        temp.text = "#" + self.emotions + " 감정에 보기 좋은 영화"
        temp.textAlignment = .left
        temp.layer.cornerRadius = 100;
        temp.sizeToFit()
        temp.font = UIFont(name: "SANGJU-Gotgam", size: 23)
        return temp
    }()
    
    let movieCollectionView: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: fl)
        return cv
    }()
    
    lazy var musicHeader : UILabel = { [weak self] in
        guard let self = self else {return UILabel()}
        let temp = UILabel()
        temp.text = "#" + self.emotions + " 감정에 듣기 좋은 음악"
        temp.textAlignment = .left
        temp.sizeToFit()
        temp.font = UIFont(name: "SANGJU-Gotgam", size: 23)
        return temp
    }()
    
    let musicCollectionView: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: fl)
        return cv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titlestr
        displaySetting()
    }
    
    
    private func displaySetting(){
        view.addSubview(todayEmotion)
        todayEmotion.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(30)
        }
        view.addSubview(emotion)
        emotion.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(todayEmotion.snp.bottom).offset(24)
            
            $0.height.equalTo(20)
        }
        view.addSubview(moviewHeader)
        moviewHeader.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(emotion.snp.bottom).offset(50)
        }
        view.addSubview(movieCollectionView)
        movieCollectionView.register(ContentCell.self, forCellWithReuseIdentifier: "moviecell")
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.showsHorizontalScrollIndicator = false
        movieCollectionView.snp.makeConstraints{
            $0.top.equalTo(moviewHeader.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
        }
        view.addSubview(musicHeader)
        
        musicHeader.snp.makeConstraints{
            $0.top.equalTo(movieCollectionView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(12)
        }
        view.addSubview(musicCollectionView)
        musicCollectionView.register(ContentCell.self, forCellWithReuseIdentifier: "moviecell")
        musicCollectionView.delegate = self
        musicCollectionView.dataSource = self
        musicCollectionView.showsHorizontalScrollIndicator = false
        musicCollectionView.snp.makeConstraints{
            $0.top.equalTo(musicHeader.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
        }
        
        
        
        
    }
}
extension EmotionContentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviecell", for: indexPath) as? ContentCell else { return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width/(3), height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }




}
