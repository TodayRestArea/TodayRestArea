//
//  LoginVC.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/09.
//

import UIKit
import SnapKit

class LoginVC: UIViewController {
    
    let logo : UIImageView = {
        let img = UIImage(named: "logo")
        let imgView = UIImageView(image: img)
        imgView.alpha = 0
        return imgView
    }()
    
    let titleView: UILabel = {
        let titleView = UILabel(frame: .zero)
        titleView.text = "하루 일기"
        titleView.textAlignment = .center
        titleView.font = UIFont(name: "SANGJU-Gotgam", size: 35)
        titleView.textColor = .black
        titleView.alpha = 0
        return titleView
    }()
    
    let subtitleView: UILabel = {
        let titleView = UILabel(frame: .zero)
        titleView.text = "당신의"
        titleView.textAlignment = .center
        titleView.font = UIFont(name: "SANGJU-Gotgam", size: 18)
        titleView.textColor = .gray
        titleView.alpha = 0
        return titleView
    }()
    
    let kakaoBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(UIImage(named: "kakao"), for: .normal)
        btn.addTarget(self, action: #selector(tapLoginBtn(_:)), for: .touchUpInside)
        btn.alpha = 0
        return btn
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0) {
            self.subtitleView.alpha = 1.0
        }
        UIView.animate(withDuration: 0){
            self.titleView.alpha = 1.0
            self.logo.alpha = 1.0
            self.kakaoBtn.alpha = 1
        }
        
    }
    
    
    private func displaySetting(){
        view.addSubview(subtitleView)
        subtitleView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
        view.addSubview(titleView)
        titleView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subtitleView.snp.bottom).offset(5)
            $0.width.equalTo(200)
            $0.height.equalTo(70)
        }
        view.addSubview(logo)
        logo.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleView.snp.bottom).offset(50)
            $0.width.height.equalTo(200)
        }
        view.addSubview(kakaoBtn)
        kakaoBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(500)
            $0.height.equalTo(80)
        }
        
    }
    
    @objc private func tapLoginBtn(_ sender: Any){
        let tmp = UINavigationController(rootViewController: MainVC())
        tmp.modalPresentationStyle = .fullScreen
        self.present(tmp, animated: false)
    }
    
}
