//
//  ViewController.swift
//  TimerApp
//
//  Created by 손성준 on 7/21/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        // 슬라이더 가운데 설정
        slider.value = 0.5
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        // 슬라이더의 밸류값이 메인레이블에 텍스트로 나와야 함
        // 슬라이더 밸류값(Float)-> 정수(Int)
        let seconds = Int(slider.value * 60) // Float 0.0 ~ 1.0
        mainLabel.text = "\(seconds)초"
        number = seconds
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 1초 마다 무언가 실행되어야 함
        timer?.invalidate()
        // 사실상 [strong self]
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            // 반복하고 싶은 코드(0초로 끝나기 전까지)
            if number > 0 {
                number -= 1
                // 슬라이더에도 적용
                slider.value = Float(number) / Float(60) // value 에 0 ~ 1 만 들어갈 수 있으니 Float으로 바꿔서 넣어줌
                // 레이블에도 적용
                mainLabel.text = "\(number)초"
            } else {
                number = 0
                mainLabel.text = "초를 선택하세요"
                // timer 비활성화
                timer?.invalidate()
                // 소리 나게 함
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기화 세팅
        mainLabel.text = "초를 선택하세요"
        // 슬라이더 가운데 설정
        slider.setValue(0.5, animated: true)
        number = 0
        timer?.invalidate()
    }
}

