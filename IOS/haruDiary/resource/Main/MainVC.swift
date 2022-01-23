
import UIKit
import SnapKit
import FSCalendar
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class MainVC: UIViewController {
    
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
    
    var selectionIdx: Int = -1
    
    var selectionDiary: DetailDiary?
    
    var clickedDate: Date = Date()
    
    var thisDays : [Diary] = []
    
    let titleView: UIView = {
        
        
        let subtitleView: UILabel = {
            let titleView = UILabel(frame: .zero)
            titleView.text = "당신의"
            titleView.textAlignment = .left
            titleView.font = UIFont(name: "JalnanOTF", size: 12)
            titleView.textColor = .gray
            return titleView
        }()
        let titleView = UILabel(frame: .zero)
        titleView.text = "하루 휴게소"
        titleView.textAlignment = .left
        titleView.font = UIFont(name: "JalnanOTF", size: 24)
        titleView.textColor = .black
        let view = UIView()
        view.addSubview(subtitleView)
        subtitleView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(15)
        }
        view.addSubview(titleView)
        titleView.snp.makeConstraints{
            $0.top.equalTo(subtitleView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        return view
    }()
    
    let calendar: FSCalendar = {
        let tmp = FSCalendar()
        tmp.locale = Locale(identifier: "ko_KR")
        tmp.calendarWeekdayView.weekdayLabels[0].text = "일"
        tmp.calendarWeekdayView.weekdayLabels[1].text = "월"
        tmp.calendarWeekdayView.weekdayLabels[2].text = "화"
        tmp.calendarWeekdayView.weekdayLabels[3].text = "수"
        tmp.calendarWeekdayView.weekdayLabels[4].text = "목"
        tmp.calendarWeekdayView.weekdayLabels[5].text = "금"
        tmp.calendarWeekdayView.weekdayLabels[6].text = "토"
        return tmp
    }()
    
    let addView: UIView = {
        let temp = UIView()
        let plusImageView = UIImageView(image: UIImage(systemName: "plus"))
        plusImageView.tintColor = .white
        temp.addSubview(plusImageView)
        plusImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        temp.backgroundColor = UIColor(red: 84/255, green: 168/255, blue: 164/255, alpha: 1)
        temp.layer.cornerRadius = 30
        return temp
    }()
    
    @objc private func clickedAddView(_ sender: Any){
        if(clickedDate.compare(Date()) == .orderedDescending){
            print(clickedDate)
            print(Date())
            print("선택이 안됩니다 ㄱㅅㄲ야")
        }else{
            if selectionIdx != -1{
                print(selectionIdx)
                getMyDiaryDetail(from: selectionIdx)
            }else {
                let nextVC = DiaryWrite()
                nextVC.date = clickedDate
                nextVC.diaryId = selectionIdx
                nextVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(nextVC, animated: false)
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        getDiaryList(thisdate: calendar.currentPage.addingTimeInterval(86400))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDiaryList(thisdate: calendar.currentPage.addingTimeInterval(86400))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDiaryList(thisdate: Date())
        makeConstraints()
        calendarSetting()
        navigationBarSetting()
        
    }
    
    private func navigationBarSetting(){
        
        let g = UITapGestureRecognizer(target: self, action: #selector(clickedAddView(_:)))
        addView.addGestureRecognizer(g)
        self.navigationController?.navigationBar.topItem?.titleView = titleView
    }
    
    private func calendarSetting(){
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerTitleFont = UIFont(name: "SANGJU-Gotgam", size: 25)
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.headerDateFormat = "  M월"
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.subtitleFont = UIFont(name: "SANGJU-Gotgam", size: 25)
        calendar.appearance.eventSelectionColor = .blue
        calendar.appearance.eventDefaultColor = .clear
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleSelectionColor = .white
        calendar.appearance.subtitleSelectionColor = .none
        calendar.appearance.weekdayFont = UIFont(name: "SANGJU-Gotgam", size: 14)
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CalanderCell")
    }
    
    private func getDiaryList(thisdate this : Date){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM"
        dateformatter.locale = Locale(identifier: "ko_KR")
        let thisdateStr = dateformatter.string(from: this)
        showMyCalneder.shared.getMyData(thisMonth: thisdateStr){ [unowned self] response in
            switch response {
            case .success(let thisdata):
                if let responseValue = thisdata as? ReponseCalendar,
                   let diaryList = responseValue.result {
                    self.thisDays = diaryList
                    self.calendar.reloadData()
                }
            case .requestErr(_):
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    private func getMyDiaryDetail(from idx: Int){
        getDetailDiary.shared.getMyData(thisMonth: idx){ [unowned self] response in
            switch response {
            case .success(let thisdata):
                if let responseValue = thisdata as? ReponseDetailCalendar,
                   let diaryList = responseValue.result {
                    let nextVC = DiaryWrite()
                    nextVC.date = clickedDate
                    nextVC.diary = diaryList
                    nextVC.diaryId = selectionIdx
                    nextVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(nextVC, animated: false)
                }
            case .requestErr(_):
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    private func makeConstraints(){
        view.addSubview(addView)
        addView.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(64)
            $0.bottom.equalToSuperview().inset(48)
        }
        view.addSubview(calendar)
        calendar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.leading.trailing.equalTo(view.safeAreaInsets)
            $0.bottom.equalTo(addView.snp.top)
        }
    }
}


extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CalanderCell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.locale = Locale(identifier: "ko_KR")
        let thisdateStr = dateformatter.string(from: date)
        var subtitle = -1
        self.thisDays.forEach{
            if $0.createdDate == thisdateStr {
                subtitle = $0.diaryId!
            }
        }
        if subtitle != -1 {
            selectionIdx = subtitle
            clickedDate = date
            getMyDiaryDetail(from: selectionIdx)
        } else if (clickedDate.compare(Date()) == .orderedDescending){
            let alert = UIAlertController(title: "미래에 일기를 쓰실려구요?", message: "저희는 겪은 경험만 분석합니다 ㅎㅎ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            selectionIdx = subtitle
            clickedDate = date
        }
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.locale = Locale(identifier: "ko_KR")
        let thisdateStr = dateformatter.string(from: date)
        var subtitle = 10
        self.thisDays.forEach{
            if $0.createdDate == thisdateStr {
                subtitle = $0.emotionId!
            }
        }
        
        let image = subtitle == 10 ? UIImage() : emotionType[subtitle]
        let size = image.size
        let widthRatio  = 40  / size.width
        let heightRatio = 40 / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor(red: 84/255, green: 168/255, blue: 164/255, alpha: 1)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 13)
    }
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        getDiaryList(thisdate: calendar.currentPage.addingTimeInterval(86400))
        DispatchQueue.main.async{
            calendar.reloadData()
        }
    }
    
    
    
    
}

extension FSCalendar: UICollectionViewDelegateFlowLayout {
}
