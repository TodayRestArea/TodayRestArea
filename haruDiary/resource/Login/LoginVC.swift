//
//  LoginVC.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/09.
//

import UIKit
import SnapKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if KeyChain.load(key: "token") != nil {
            print("222222222222q22")
           goMain()
        }
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
    
    private func goMain(){
        let tmp = UINavigationController(rootViewController: MainVC())
        tmp.modalPresentationStyle = .fullScreen
        self.present(tmp, animated: false, completion: nil)
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
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("--------------------------------------------")
                print("loginWithKakaoTalk() success.")
                if let kakaoData = oauthToken {
                    LoginService.shared.kakaoLogin(accessToken: kakaoData.accessToken) { result in
                        switch result {
                        case .success(let loginData):
                            print("success")
                            if let userData = loginData as? LoginResponse {
                                if let tokenData = userData.result.accessToken.data(using: String.Encoding.utf8) {
                                    KeyChain.save(key: "token", data: tokenData)
                                    self.goMain()
                                }
                            }
                            print("액세스 토큰 : \(kakaoData.accessToken)")
                            print("리프레시 토큰 : \(kakaoData.refreshToken)")
                            self.goMain()
                        case .requestErr(_):
                            print("requestErr")
                        case .pathErr:
                            print("액세스 토큰 : \(kakaoData.accessToken)")
                            print("pathErr")
                            print("여기")
                        case .serverErr:
                            print("serverErr")
                        case .networkFail:
                            print("networkFail")
                        }
                    }
                }
            }
        }
        
    }
}
