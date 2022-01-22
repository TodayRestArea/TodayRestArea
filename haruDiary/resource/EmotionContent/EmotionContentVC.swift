
import UIKit
import SwiftUI
import SafariServices

class EmotionContentVC: UIViewController, tapMoreBtn {
    
    var titlestr = String()
    var date = Date()
    var content: contentResponse?
    var emotions = ["","분노","슬픔","불안","당황","기쁨"]
    let emotionType: [UIImage] = {
        var tmp =  [UIImage]()
        tmp.append(UIImage(named: "q")!)
        tmp.append(UIImage(named: "angry")!)
        tmp.append(UIImage(named: "sad")!)
        tmp.append(UIImage(named: "nervous")!)
        tmp.append(UIImage(named: "panic")!)
        tmp.append(UIImage(named: "happy")!)
        return tmp
    }()
    
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
        temp.text = "#" + self.emotions[content?.emotionId ?? 0]
        temp.textAlignment = .left
        temp.layer.cornerRadius = 100;
        temp.sizeToFit()
        temp.font = UIFont(name: "SANGJU-Gotgam", size: 18)
        return temp
    }()
    
    lazy var moviewHeader : UILabel = { [weak self] in
        guard let self = self else {return UILabel()}
        let temp = UILabel()
        temp.text = "#" + self.emotions[content?.emotionId ?? 0] + " 감정에 보기 좋은 영화"
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
        temp.text = "#" + self.emotions[content?.emotionId ?? 0] + " 감정에 듣기 좋은 음악"
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
        makeConstraints()
        collectionviewSetting()
    }
    
    private func collectionviewSetting(){
        movieCollectionView.register(recommendMovieCell.self, forCellWithReuseIdentifier: "recommendMovieCell")
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.showsHorizontalScrollIndicator = false
        musicCollectionView.register(recommendMusicCell.self, forCellWithReuseIdentifier: "recommendMusicCell")
        musicCollectionView.delegate = self
        musicCollectionView.dataSource = self
        musicCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func makeConstraints(){
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
        movieCollectionView.snp.makeConstraints{
            $0.top.equalTo(moviewHeader.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(260)
        }
        view.addSubview(musicHeader)
        
        musicHeader.snp.makeConstraints{
            $0.top.equalTo(movieCollectionView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(12)
        }
        view.addSubview(musicCollectionView)
        musicCollectionView.snp.makeConstraints{
            $0.top.equalTo(musicHeader.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.bounds.width / 2)
        }
    }
    func tap(v: UIViewController) {
        self.navigationController?.pushViewController(v, animated: true)
    }
    
}
extension EmotionContentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieCollectionView { return (content?.recommendMovies?.count)!}
        else { return (content?.recommendMusics?.count)!}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == movieCollectionView {
            guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendMovieCell", for: indexPath) as? recommendMovieCell else { return UICollectionViewCell()}
            movieCell.movieInfo = content?.recommendMovies?[indexPath.row]
            movieCell.delegate = self
            return movieCell
        } else {
            guard let musicCell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendMusicCell", for: indexPath) as? recommendMusicCell else { return UICollectionViewCell() }
            musicCell.delegate = self
            musicCell.musicInfo = content?.recommendMusics?[indexPath.row]
            return musicCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == movieCollectionView ? CGSize(width: view.bounds.width / 2, height: 260) : CGSize(width: view.bounds.width / 2, height: view.bounds.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == movieCollectionView {
            let temp = content?.recommendMovies?[indexPath.row]
            let blogUrl = NSURL(string: temp!.infoUrl!)
            let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl as! URL)
            self.navigationController?.pushViewController(blogSafariView, animated: true)
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
