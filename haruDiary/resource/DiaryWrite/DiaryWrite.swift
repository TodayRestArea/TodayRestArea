//
//  DiaryWrite.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/09.
//

import UIKit
import SnapKit
import SwiftUI

class DiaryWrite: UIViewController{
    
    var date = Date()
    let weatherView = UIView()
    var diary: Diary? = nil
    var weatherIdx : Int?
    var buttonsText :  [String] = ["맑음","흐림","비","눈"]
    var buttons = [customBtn]()
    var buttonsView = UIView()
    lazy var dateLabel: UILabel = { [weak self] in
        guard let self = self else { return UILabel() }
        let tmp = UILabel()
        let datefommater = DateFormatter()
        datefommater.dateFormat = "yyyy년 M월 d일 (E)"
        datefommater.locale = Locale(identifier: "ko_KR")
        tmp.text = datefommater.string(from: self.date)
        tmp.font = UIFont(name: "SANGJU-Gotgam", size: 18)
        
        tmp.textAlignment = .center
        return tmp
    }()
    let textView = UITextView()
    let saveBtn: UIView = {
        let btn = UIView()
        btn.backgroundColor = .gray
        let txt = UILabel()
        txt.text = "이미지대체예정"
        txt.textAlignment = .center
        btn.addSubview(txt);
        txt.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        return btn;
    }()
    @objc private func tapSaveBtn(_ sender: Any){
        let emotionvc = EmotionContentVC()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 dd일 당신의 그날"
        print(formatter.string(from: date))
        emotionvc.titlestr = formatter.string(from: date)
        emotionvc.date = date
        self.navigationController?.pushViewController(emotionvc, animated: false)
    }
    @objc private func changeWeather(Btn : customBtn){
        print("cute")
        buttons[Btn.type!].isSelected = true
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        haveContents()
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
        textView.delegate = self
        textView.font = UIFont(name: "SANGJU-Gotgam", size: 25)
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.layer.borderWidth = 1
        textView.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.9)
            $0.height.equalTo(view.bounds.height * 0.6)
        }
        
        view.addSubview(saveBtn)
        let g = UITapGestureRecognizer(target: self, action: #selector(tapSaveBtn(_:)))
        saveBtn.addGestureRecognizer(g);
        saveBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(80)
        }
        
        
        
    }
    
    private func haveContents(){
        if diary?.contents != nil {
            if diary?.emotionIdx != "0"  {
                
            } else{
                self.textView.text = diary?.contents!
                self.weatherIdx = diary?.weatherIdx!
                buttons[weatherIdx!].isSelected = true
                
            }
        } else{
            
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

extension DiaryWrite: UITextViewDelegate{
    
}

class customBtn: UIButton{
    var type: Int?
}
