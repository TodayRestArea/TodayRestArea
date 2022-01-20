//
//  DiaryWrite.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/09.
//

import UIKit
import SnapKit
import SwiftUI

class DiaryWrite: UIViewController, UITextViewDelegate{
    
    var date = Date()
    var nowMode: Int = 0
    var editmode = false
    let weatherView = UIView()
    var diary: DetailDiary?
    var diaryId: Int = -1
    var weatherIdx : Int = 0
    var buttonsText :  [String] = ["맑음","흐림","비","눈"]
    var buttons = [customBtn]()
    var buttonsView = UIView()
    
    lazy var dateLabel: UILabel = { [weak self] in
        guard let self = self else { return UILabel() }
        let tmp = UILabel()
        let datefommater = DateFormatter()
        datefommater.dateFormat = "yyyy년 M월 d일 E요일"
        datefommater.locale = Locale(identifier: "ko_KR")
        tmp.text = datefommater.string(from: self.date)
        tmp.font = UIFont(name: "SANGJU-Gotgam", size: 25)
        tmp.textAlignment = .center
        return tmp
    }()
    
    let textView = UITextView()
    let saveBtn: UIView = {
        let btn = UIView()
        let txt = UILabel()
        txt.text = "save"
        txt.textAlignment = .center
        btn.addSubview(txt);
        txt.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        return btn;
    }()
    
    let analyzeBtn: UIView = {
        let btn = UIView()
        let txt = UILabel()
        txt.text = "Analyze"
        txt.textAlignment = .center
        btn.addSubview(txt);
        txt.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        return btn;
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        makeNavigationBar()
        haveContents()
    }
    
    private func makeNavigationBar(){
        let rightBarItem = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(tapEditBtn(_:)))
        rightBarItem.tintColor = .black
        let rightBarItemd = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(tapDeleteBtn(_:)))
        rightBarItem.tintColor = .red
        self.navigationItem.rightBarButtonItems = [rightBarItem, rightBarItemd]
        
    }
    
    private func makeConstraints(){
        title = ""
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.width.equalTo(view.bounds.width)
            $0.height.equalTo(30)
        }
        view.addSubview(buttonsView)
        buttonsView.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.5)
            $0.height.equalTo(50)
        }
        for i in 0...3 {
            let temp = customBtn()
            temp.setTitle(buttonsText[i], for: .normal)
            temp.type = i
            temp.addTarget(self, action: #selector(changeWeather(Btn:)), for: .touchUpInside)
            temp.setTitleColor(.black, for: .normal)
            buttons.append(temp)
        }
        for i in buttons {
            buttonsView.addSubview(i)
        }
        buttons[0].snp.makeConstraints{
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.125)
        }
        buttons[1].snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.125)
            $0.leading.equalTo(buttons[0].snp.trailing)
        }
        buttons[2].snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.125)
            $0.leading.equalTo(buttons[1].snp.trailing)
        }
        buttons[3].snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.125)
            $0.leading.equalTo(buttons[2].snp.trailing)
        }
        
        view.addSubview(textView)
        textView.font = UIFont(name: "온글잎 보현체", size: 30)
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        textView.layer.cornerRadius = 15
        
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.snp.makeConstraints{
            $0.top.equalTo(buttonsView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.9)
            $0.height.equalTo(view.bounds.height * 0.6)
        }
        
        
        view.addSubview(saveBtn)
        let g = UITapGestureRecognizer(target: self, action: #selector(tapSaveButton(_:)))
        saveBtn.addGestureRecognizer(g);
        saveBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(100)
        }
        
    }
    
    @objc func tapDeleteBtn(_ sender: Any){
        let alert = UIAlertController(title: "정말로 삭제하시겠습니까?", message: "삭제는 복구할수 없습니다", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default , handler: { _ in
            DeleteDiary.shared.getMyData(diaryId: "\(self.diaryId)"){ [weak self] response in
                switch response {
                case .success(let thisdata):
                    if let responseValue = thisdata as? DiaryWriteResponse,
                       responseValue.isSuccess == true {
                        self?.navigationController?.popViewController(animated: false)
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
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel , handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc  func tapAnalyzeBtn(_ sender: Any){
        AnalyzeDiary.shared.getMyData(diaryId: "\(self.diaryId)"){ [weak self] response in
            switch response {
            case .success(let thisdata):
                if let responseValue = thisdata as? AnalyzeDiaryResponse,
                   let temp = responseValue.result {
                    let tmp = EmotionContentVC()
                    tmp.content = temp
                    self?.navigationController?.pushViewController(tmp, animated: false)
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
    
    @objc  func tapEditBtn(_ sender : Any){
        nowMode = 1
        let temp = saveBtn.subviews[0] as? UILabel
        temp?.text = "save"
        nonsavemode()
    }
    
    @objc func tapSaveButton(_ sender: Any){
        if(self.textView.text == ""){
            let alert = UIAlertController(title: "일기를 입력해주세요", message: "일기 내용은 꼭 입력하셔야 합니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        } else if(nowMode == 1){//edit after save
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            dateformatter.string(from: self.date)
            EditDiary.shared.saveDiary(weatherIdx: self.weatherIdx, contents: self.textView.text, diaryId: "\(self.diaryId)"){ [unowned self] response in
                switch response {
                case .success(let temp):
                    if let content = temp as? DiaryWriteResponse,
                       let result = content.result {
                        savebutnoanalyzemode(content: self.textView.text, weather: self.weatherIdx)
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
            let temp = saveBtn.subviews[0] as? UILabel
            temp?.text = "analyze"
            nowMode = 2
        } else if (nowMode == 0){//아무것도 없을떄 세이브 누를시
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            dateformatter.string(from: self.date)
            WriteDiary.shared.saveDiary(weatherIdx: weatherIdx, contents: self.textView.text, cratedAt: dateformatter.string(from: self.date)){[unowned self] response in
                switch response {
                case .success(let temp):
                    if let content = temp as? DiaryWriteResponse,
                       let result = content.result,
                       let real = result.diaryId{
                        self.diaryId = real
                        getDetailDiary.shared.getMyData(thisMonth: real){ [unowned self] response in
                            switch response {
                            case .success(let thisdata):
                                if let responseValue = thisdata as? ReponseDetailCalendar,
                                   let diaryList = responseValue.result {
                                
                                    self.diary = diaryList
                                    savebutnoanalyzemode(content: self.diary?.contents, weather: self.diary?.weatherId)
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
            let alert = UIAlertController(title: "일기 저장이 완료되었습니다", message: "일기를 저장했으니 이제 감정 분석을 해볼까요?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            let temp = saveBtn.subviews[0] as? UILabel
            temp?.text = "analyze"
            nowMode = 2
        } else if (nowMode == 2){
            AnalyzeDiary.shared.getMyData(diaryId: "\(self.diaryId)"){ [weak self] response in
                switch response {
                case .success(let thisdata):
                    if let responseValue = thisdata as? AnalyzeDiaryResponse,
                       let temp = responseValue.result {
                        let tmp = EmotionContentVC()
                        tmp.content = temp
                        self?.navigationController?.pushViewController(tmp, animated: false)
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
        
    }
    @objc private func changeWeather(Btn : customBtn){
        buttons[Btn.type!].isSelected = true
        self.weatherIdx = Btn.type!
        for i in 0...3 {
            if i == Btn.type! {
                buttons[i].isSelected = true
                buttons[i].setTitleColor(.black, for: .normal)
            } else{
                buttons[i].isSelected = false
                buttons[i].setTitleColor(.gray, for: .normal)
            }
        }
        print(self.weatherIdx)
        print(textView.text)
    }
    
    func buttononit(i: Int, dontuse: Bool){
        buttons[i].isSelected = true;
        for idx in 0...3 {
            if buttons[idx].isSelected{
                self.weatherIdx = i
                buttons[idx].setTitleColor(.black, for: .normal)
                if(dontuse) {
                    buttons[idx].isEnabled = false
                } else {
                    buttons[idx].isEnabled = true
                }
            } else{
                buttons[idx].isSelected = false
                buttons[idx].setTitleColor(.gray, for: .normal)
                if(dontuse) {
                    buttons[idx].isEnabled = false
                }else {
                    buttons[idx].isEnabled = true
                }
            }
        }
    }
    
    func nonsavemode(){
        self.navigationItem.rightBarButtonItems?[0].isEnabled = false
        self.navigationItem.rightBarButtonItems?[0].tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.navigationItem.rightBarButtonItems?[1].isEnabled = false
        self.navigationItem.rightBarButtonItems?[1].tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        buttononit(i: 0, dontuse: false)
        textView.isEditable = true
    }
    
    func savebutnoanalyzemode(content: String?, weather: Int?){
        print(content!)
        self.textView.text = content
        buttononit(i: weather!, dontuse: true)
        let tmp = saveBtn.subviews[0] as? UILabel
        tmp?.text = "Analyze"
        self.navigationItem.rightBarButtonItems?[0].isEnabled = true
        self.navigationItem.rightBarButtonItems?[0].tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationItem.rightBarButtonItems?[1].isEnabled = true
        self.navigationItem.rightBarButtonItems?[1].tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        analyzeBtn.isUserInteractionEnabled = true
        analyzeBtn.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textView.isEditable = false
    }
    
    
    private func haveContents(){
        if diaryId != -1 {
            nowMode = 2
            savebutnoanalyzemode(content: self.diary?.contents, weather: self.diary?.weatherId)
        } else{
            nowMode = 0
            nonsavemode()
        }
    }
}


extension UINavigationController {
    func popViewController(animated: Bool, completion:@escaping (()->())) -> UIViewController? {
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        let poppedViewController = self.popViewController(animated: animated)
        CATransaction.commit()
        return poppedViewController
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion:@escaping (()->())) {
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}

class customBtn: UIButton{
    var type: Int?
}
