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
    let weatherView = UIView()
    var diary: Diary? = nil
    var diaryId: Int?
    var weatherIdx : Int?
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
        tmp.font = UIFont(name: "SANGJU-Gotgam", size: 18)
        
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
            $0.width.equalTo(view.bounds.width * 0.5)
            $0.height.equalTo(50)
        }
        view.addSubview(buttonsView)
        buttonsView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(dateLabel.snp.trailing)
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
        textView.font = UIFont(name: "SANGJU-Gotgam", size: 25)
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        textView.layer.cornerRadius = 15
        
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.9)
            $0.height.equalTo(view.bounds.height * 0.6)
        }
        
        
        view.addSubview(saveBtn)
        let g = UITapGestureRecognizer(target: self, action: #selector(tapSaveButton(_:)))
        saveBtn.addGestureRecognizer(g);
        saveBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(50)
            $0.trailing.equalTo(view.snp.centerX)
            $0.width.equalTo(200)
            $0.height.equalTo(80)
        }
        
        view.addSubview(analyzeBtn)
        let ge = UITapGestureRecognizer(target: self, action: #selector(tapAnalyzeBtn(_:)))
        analyzeBtn.addGestureRecognizer(ge);
        analyzeBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.equalTo(view.snp.centerX)
            $0.width.equalTo(200)
            $0.height.equalTo(80)
            
        }
    }
    @objc func tapDeleteBtn(_ sender: Any){
        DeleteDiary.shared.getMyData(diaryId: "\(String(describing: self.diaryId))"){ [weak self] response in
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
    }
    
    @objc  func tapAnalyzeBtn(_ sender: Any){
        AnalyzeDiary.shared.getMyData(diaryId: "\(String(describing: self.diaryId))"){ [weak self] response in
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
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.string(from: self.date)
        EditDiary.shared.saveDiary(weatherIdx: weatherIdx!, contents: self.textView.text, cratedAt: dateformatter.string(from: self.date), diaryId: "\(String(describing: self.diaryId))"){ [weak self] response in
            switch response {
            case .success(let temp):
                if let content = temp as? DiaryWriteResponse,
                   let result = content.result?.diaryIdx {
                    self?.diaryId = result
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
        for i in 0...3 {
            if buttons[weatherIdx!].isSelected {
                self.weatherIdx = i
                buttons[i].setTitleColor(.black, for: .normal)
            } else{
                buttons[i].isSelected = false
                buttons[i].setTitleColor(.gray, for: .normal)
            }
            buttons[i].isEnabled = true
        }
        textView.isEditable = true
        saveBtn.isHidden = false
    }
    
    @objc func tapSaveButton(_ sender: Any){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.string(from: self.date)
        WriteDiary.shared.saveDiary(weatherIdx: weatherIdx ?? 1, contents: self.textView.text, cratedAt: dateformatter.string(from: self.date)){ [weak self] response in
            switch response {
            case .success(let temp):
                if let content = temp as? DiaryWriteResponse,
                   let result = content.result?.diaryIdx {
                    self?.diaryId = result
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
        for i in 0...3 {
            if buttons[i].isSelected {
                self.weatherIdx = i
                buttons[i].setTitleColor(.black, for: .normal)
            } else{
                buttons[i].isSelected = false
                buttons[i].setTitleColor(.gray, for: .normal)
            }
            buttons[i].isEnabled = false
        }
        saveBtn.layer.opacity = 0.5
        analyzeBtn.layer.opacity = 1
        analyzeBtn.isExclusiveTouch = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @objc private func changeWeather(Btn : customBtn){
        buttons[Btn.type!].isSelected = true
        self.weatherIdx = 0
        for i in 0...3 {
            if i == Btn.type! {
                self.weatherIdx = i
                buttons[i].setTitleColor(.black, for: .normal)
            } else{
                buttons[i].isSelected = false
                buttons[i].setTitleColor(.gray, for: .normal)
            }
        }
    }
    
    private func haveContents(){
//        if diary?.contents != nil {
//            if diary?.emotionIdx != "0"  {// 분석하고 일기도 쓴상태
//                textView.isEditable = false
//                buttons[weatherIdx!].isSelected = true
//                for i in 0...3 {
//                    if buttons[weatherIdx!].isSelected {
//                        self.weatherIdx = i
//                        buttons[i].setTitleColor(.black, for: .normal)
//                    } else{
//                        buttons[i].isSelected = false
//                        buttons[i].setTitleColor(.gray, for: .normal)
//                    }
//                    buttons[i].isEnabled = false
//                }
//                saveBtn.isHidden = true
//            } else{//분석하기는 안됬지만, 일기는 쓴 상탱
//                self.textView.text = diary?.contents!
//                self.weatherIdx = diary?.weatherIdx!
//                buttons[weatherIdx!].isSelected = true
//                for i in 0...3 {
//                    if buttons[weatherIdx!].isSelected {
//                        self.weatherIdx = i
//                        buttons[i].setTitleColor(.black, for: .normal)
//                    } else{
//                        buttons[i].isSelected = false
//                        buttons[i].setTitleColor(.gray, for: .normal)
//                    }
//                }
//                saveBtn.isHidden = true
//                analyzeBtn.isHidden = false
//            }
//        } else{//처음 들어올때
//            analyzeBtn.layer.opacity = 0.5
//            analyzeBtn.isExclusiveTouch = true;
//            self.navigationItem.rightBarButtonItems?[0].isEnabled = false
//            self.navigationItem.rightBarButtonItems?[0].tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//            self.navigationItem.rightBarButtonItems?[1].isEnabled = false
//            self.navigationItem.rightBarButtonItems?[1].tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        }
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
