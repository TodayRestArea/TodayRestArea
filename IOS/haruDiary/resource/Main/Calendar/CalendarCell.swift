
import UIKit
import SnapKit
import FSCalendar

class CalendarCell: FSCalendarCell {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeConstraints()
    }
    
    private func makeConstraints(){
        self.addSubview(emotionview)
        emotionview.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(-15)
        }
        
        
    }

}
