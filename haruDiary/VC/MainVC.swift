
import UIKit
import SnapKit
import FSCalendar

class MainVC: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetting()
        calendarSetting()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    
    
    private func displaySetting(){
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height+50)
        let barLogo = UIBarButtonItem(customView: logo)
        self.navigationItem.leftBarButtonItem = barLogo
    }
    private func calendarSetting(){
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.eventSelectionColor = .clear
        calendar.appearance.eventDefaultColor = .clear
        calendar.appearance.headerTitleFont = UIFont(name: "SANGJU-Gotgam", size: 25)
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.headerDateFormat = "M 월"
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleSelectionColor = .black
        calendar.appearance.weekdayFont = UIFont(name: "SANGJU-Gotgam", size: 14)
        view.addSubview(calendar)
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "CalanderCell")
        calendar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(12)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(withIdentifier: "CalanderCell", for: date, at: position) as? FSCalendarCell else { return FSCalendarCell()}
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmp = DiaryWrite()
        tmp.date = date
        self.navigationController?.pushViewController(tmp, animated: false)
        displaySetting()
        }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .clear
    }
    
    
    
    
}

extension FSCalendar: UICollectionViewDelegateFlowLayout {
    
}
