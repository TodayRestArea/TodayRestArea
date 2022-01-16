
import UIKit
import SnapKit
import FSCalendar
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class MainVC: UIViewController {
    
    let emotionType: [String] = {
        var tmp =  [String]()
        tmp.append("?")
        tmp.append("😡")
        tmp.append("😢")
        tmp.append("😵‍💫")
        tmp.append("😭")
        tmp.append("😱")
        tmp.append("🤗")
        return tmp
    }()
    var selectionIdx: Int?
    var selectionDiary : Diary?
    var clickedDate: Date?
    var thisDays : [Diary]?
    let logo: UIView = {
        let titleView: UILabel = {
            let titleView = UILabel(frame: .zero)
            titleView.text = "하루 일기"
            titleView.textAlignment = .left
            titleView.font = UIFont(name: "SANGJU-Gotgam", size: 30)
            titleView.textColor = .black
            return titleView
        }()
        
        let subtitleView: UILabel = {
            let titleView = UILabel(frame: .zero)
            titleView.text = "당신의"
            titleView.textAlignment = .left
            titleView.font = UIFont(name: "SANGJU-Gotgam", size: 22)
            titleView.textColor = .gray
            return titleView
        }()
        
        let view = UIView()
        view.addSubview(subtitleView)
        subtitleView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        view.addSubview(titleView)
        titleView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(subtitleView.snp.bottom)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
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
        temp.addSubview(plusImageView)
        plusImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        return temp
    }()
    
    
    
    
    
    @objc private func clickedAddView(_ sender: Any){
        let nextVC = DiaryWrite()
        
        guard let clickedDate = clickedDate else {
            print("선택을 하셔야합니다 ㄱㅅㄲ야")
            return
        }
        if(clickedDate.compare(Date()) == .orderedDescending){
            print(clickedDate)
            print(Date())
            print("선택이 안됩니다 ㄱㅅㄲ야")
        }else{
            print(clickedDate)
            print(Date())
            print("선택")
            nextVC.date = clickedDate
           // getMyDiaryDetail(from: selectionIdx ?? 0)
            //nextVC.diary = selectionDiary
          
            nextVC.modalPresentationStyle = .fullScreen
           
            self.navigationController?.pushViewController(nextVC, animated: false)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        calendarSetting()
        navigationBarSetting()
        getDiaryList(thisdate: Date())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func navigationBarSetting(){
        let barLogo = UIBarButtonItem(customView: logo)
        self.navigationItem.leftBarButtonItem = barLogo
        let g = UITapGestureRecognizer(target: self, action: #selector(clickedAddView(_:)))
        addView.addGestureRecognizer(g)
    }
    
    private func calendarSetting(){
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerTitleFont = UIFont(name: "SANGJU-Gotgam", size: 25)
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.headerDateFormat = "M 월"
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.subtitleFont = UIFont(name: "SANGJU-Gotgam", size: 25)
        calendar.appearance.eventSelectionColor = .blue
        calendar.appearance.eventDefaultColor = .clear
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleSelectionColor = .green
        calendar.appearance.subtitleSelectionColor = .none
        calendar.appearance.weekdayFont = UIFont(name: "SANGJU-Gotgam", size: 14)
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CalanderCell")
    }
    
    private func getDiaryList(thisdate this : Date){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyMM"
        dateformatter.locale = Locale(identifier: "ko_KR")
        let thisdateStr = dateformatter.string(from: this)
        showMyCalneder.shared.getMyData(thisMonth: thisdateStr){ [weak self] response in
            switch response {
            case .success(let thisdata):
                if let responseValue = thisdata as? ReponseCalendar,
                   let diaryList = responseValue.result as? [Diary] {
                    self?.thisDays = diaryList
                }
                print("success")
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
        getDetailDiary.shared.getMyData(thisMonth: idx){[weak self]response in
            switch response {
            case .success(let thisdata):
                if let responseValue = thisdata as? ReponseDetailCalendar,
                   let diaryList = responseValue.result as Diary? {
                    self?.selectionDiary = diaryList
                }
                print("success")
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
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(12)
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
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy-MM-dd"
//        dateformatter.locale = Locale(identifier: "ko_KR")
//        let thisdateStr = dateformatter.string(from: date)
//        let subtitle = thisDays?.filter{
//            return $0.createdAt == thisdateStr
//        }
//        selectionIdx = subtitle?[0].diaryIdx
        clickedDate = date
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .clear
    }
    
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.locale = Locale(identifier: "ko_KR")
        let thisdateStr = dateformatter.string(from: date)
        let subtitle = thisDays?.filter{
            return $0.createdAt == thisdateStr
        }
        return subtitle?[0].emotionIdx
        
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 20)
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
