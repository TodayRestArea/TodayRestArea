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
    var checkImgView = [UIImageView]()
    let sunBtn: UIView = {
        let tmp = UIView()
        let sun = UIImageView(image: UIImage(named: "sunny"))
        tmp.addSubview(sun)
        sun.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        return tmp
    }()
    @objc func tapSun(_ sender: Any){
        for i  in 0...4 {
            if i == 0 {
                checkImgView[i].isHidden = false
            } else{
                checkImgView[i].isHidden = true
            }
        }
    }
    let rainbowBtn: UIView = {
        let tmp = UIView()
        let sun = UIImageView(image: UIImage(named: "rainbow"))
        tmp.addSubview(sun)
        sun.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        return tmp
    }()
    @objc func taprainbow(_ sender: Any){
        for i  in 0...4 {
            if i == 4 {
                checkImgView[i].isHidden = false
            } else{
                checkImgView[i].isHidden = true
            }
        }
    }
    let cloudBtn: UIView = {
        let tmp = UIView()
        let sun = UIImageView(image: UIImage(named: "cloud"))
        tmp.addSubview(sun)
        sun.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        return tmp
    }()
    @objc func tapCloud(_ sender: Any){
        for i  in 0...4 {
            if i == 1 {
                checkImgView[i].isHidden = false
            } else{
                checkImgView[i].isHidden = true
            }
        }
    }
    let rainBtn: UIView = {
        let tmp = UIView()
        let sun = UIImageView(image: UIImage(named: "rain"))
        tmp.addSubview(sun)
        sun.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        return tmp
    }()
    @objc func tapRain(_ sender: Any){
        for i  in 0...4 {
            if i == 2 {
                checkImgView[i].isHidden = false
            } else{
                checkImgView[i].isHidden = true
            }
        }
    }
    let snowBtn: UIView = {
        let tmp = UIView()
        let sun = UIImageView(image: UIImage(named: "snow"))
        tmp.addSubview(sun)
        sun.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        return tmp
    }()
    @objc func tapSnow(_ sender: Any){
        for i  in 0...4 {
            if i == 3 {
                checkImgView[i].isHidden = false
            } else{
                checkImgView[i].isHidden = true
            }
        }
    }
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetting()
    }
    
    private func displaySetting(){
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.width.equalTo(view.bounds.width * 0.5)
            $0.height.equalTo(50)
        }
        
        view.addSubview(sunBtn)
        var gesture = UITapGestureRecognizer(target: self, action: #selector(tapSun(_:)))
        sunBtn.addGestureRecognizer(gesture)
        sunBtn.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(dateLabel.snp.trailing)
            $0.width.equalTo(view.bounds.width * 0.1)
        }
        view.addSubview(cloudBtn)
        gesture = UITapGestureRecognizer(target: self, action: #selector(tapCloud(_:)))
        cloudBtn.addGestureRecognizer(gesture)
        cloudBtn.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(sunBtn.snp.trailing)
            $0.width.equalTo(view.bounds.width * 0.1)
        }
        view.addSubview(rainBtn)
        gesture = UITapGestureRecognizer(target: self, action: #selector(tapRain(_:)))
        rainBtn.addGestureRecognizer(gesture)
        rainBtn.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(cloudBtn.snp.trailing)
            $0.width.equalTo(view.bounds.width * 0.1)
        }
        view.addSubview(snowBtn)
        gesture = UITapGestureRecognizer(target: self, action: #selector(tapSnow(_:)))
        snowBtn.addGestureRecognizer(gesture)
        snowBtn.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(rainBtn.snp.trailing)
            $0.width.equalTo(view.bounds.width * 0.1)
        }
        view.addSubview(rainbowBtn)
        gesture = UITapGestureRecognizer(target: self, action: #selector(taprainbow(_:)))
        rainbowBtn.addGestureRecognizer(gesture)
        rainbowBtn.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(snowBtn.snp.trailing)
            $0.width.equalTo(view.bounds.width * 0.1)
        }
        for i in 0...4 {
            checkImgView.append(UIImageView(image: UIImage(systemName: "checkmark")))
            view.addSubview(checkImgView[i])
            if i==0 {
                checkImgView[i].snp.makeConstraints{
                    $0.top.equalTo(view.safeAreaLayoutGuide)
                    $0.bottom.equalTo(dateLabel.snp.bottom)
                    $0.leading.equalTo(dateLabel.snp.trailing)
                    $0.width.equalTo(view.bounds.width * 0.1)
                }
            } else {
                checkImgView[i].snp.makeConstraints{
                    $0.top.equalTo(view.safeAreaLayoutGuide)
                    $0.bottom.equalTo(dateLabel.snp.bottom)
                    $0.leading.equalTo(checkImgView[i-1].snp.trailing)
                    $0.width.equalTo(view.bounds.width * 0.1)
                }
            }
            checkImgView[i].isHidden = true;
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
