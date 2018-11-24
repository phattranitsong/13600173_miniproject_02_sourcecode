//
//  ViewController.swift
//  13600173_mnp_THL_1
//
//  Created by songsuay on 11/9/18.
//  Copyright © 2018 ICTSUIM. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    var audioplayer: AVAudioPlayer!

    @IBOutlet weak var inputNameTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var yourScoreShow: UILabel!
    @IBOutlet weak var numQuestionLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    
    @IBOutlet weak var showGift: UIImageView!
    @IBOutlet weak var showLabel: UILabel!
    @IBAction func clickRandomBt(_ sender: UIButton) {
        changGift()
    }
    
    let allQuestion = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    var correctCount : Int = 0
    var wrongCount : Int = 0
    
    var randomGift : Int = 0
    var giftImg = ["brand","book","poj","pen","passport"]
    
    var checkRandom : Bool = true //สุ่ม1ครั้ง
    
    var checkScore : Bool = false //ให้สุ่มไม่ได้ถ้าscore<10
    
    var timer = Timer()
    //ตัวแปร หรือ instant หรือ Object ของเวลาที่ใช้นับถอยหลัง
    var limitTime = 60
    //for 10 sec.
    var checkStatusToPlay = false
    //เริ่มต้นให้เป็น False เพื่อให้กดเล่นยังไม่ได้
    
    
    
    let nameSound = ["sayno","sayyes"]
    
    func nameChange(){
        
    }

    @objc func processTimer() {
        if limitTime > 0 {
            //ถ้าเวลายังมากกว่า 0 ก็ให้นับถอยหลัง คือลบค่าไปเรื่อยๆ
            limitTime -= 1
            timerLabel.text = "Timer: \(limitTime)"
        
        }else if limitTime == 0{
            checkStatusToPlay = false
            print("TimeUp")

    
            
            let alert = UIAlertController(title: "AWSOME", message: "หมดเวลา!! \nคะแนนของคุณคือ : \(score)", preferredStyle: .alert)
            
            let restartAction = UIAlertAction( title: "เริ่มใหม่อีกครั้ง", style: .default, handler:{
                UIAlertAction in self.startOver()
                
            })
            
            alert.addAction(restartAction)
            
            present(alert,animated: true,completion: nil)
            
            //ถ้าเวลาเป็น 0 ก็ให้เปลี่ยนสถานะเป็น False เพื่อให้กดเล่นต่อไม่ได้
        }else{
            timer.invalidate()
            //นอกเหลือจากนั้น ให้หยุดเวลา
        }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        //ฟังก์ชันนี้โยงกับกลุ่ม Click to play
//        let inputName = inputNameTextField.text
//        let isEmpty = (inputNameTextField.text ?? "").isEmpty
        if inputNameTextField.text?.isEmpty ?? true {
            timer = Timer.scheduledTimer(timeInterval: 00, target: self, selector: #selector(ViewController.processTimer), userInfo: nil, repeats: false)
            //สั่งให้เวลาเริ่มเดิน
            
            let alertName = UIAlertController(title: "AWSOME", message: "ใส่ชื่อก่อนเล่นนะคะ", preferredStyle: .alert)
            
            let restartAction = UIAlertAction( title: "ตกลง", style: .default, handler:{
                UIAlertAction in self.startOver()
                
            })
            alertName.addAction(restartAction)
            
            present(alertName,animated: true,completion: nil)
            
            checkStatusToPlay = false
            limitTime = 60
            timerLabel.text = "Timer: \(limitTime)"
            
        } else {
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.processTimer), userInfo: nil, repeats: true)
            //สั่งให้เวลาเริ่มเดิน
            
            checkStatusToPlay = true
            
        }
        showName.text = inputNameTextField.text
        
        //สั่งให้สถานะการเล่นเป็นจริง เพื่อให้เล่นได้
    }
    
    @IBAction func nextSum(_ sender: UIButton) {
//        if checkScore {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let nextPage = storyBoard.instantiateViewController(withIdentifier: "Gift") as! ViewController
//            self.present(nextPage, animated: true, completion: nil)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view, typically from a nib.
        
        showName?.text = inputNameTextField?.text

        questionLabel?.text = allQuestion.list[questionNumber].questionText
        
//         yourScoreShow.text = " YOUR SCORE = \(score)"
        
    }
    
    @IBAction func answerButton(_ sender: UIButton) {
        
        // playSound(soundName: nameSound[sender.tag-1])
        
        if checkStatusToPlay {
            
            if sender.tag == 1{
                print(true)
                pickedAnswer = true
            }else if sender.tag == 2 {
                print("picked false")
                pickedAnswer = false
            }
            
            checkAnswer()
            questionNumber = questionNumber+1
            //        nextQuestion()
            updateUI()
            
        }
    
    }//end function answerPressed

    func checkAnswer(){
        
        let correctAnswer = allQuestion.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer{
            
//            print("you got it")
            score = score + 1
            correctCount = correctCount + 1
            playSound("sayyes")
            ProgressHUD.showSuccess("ถูกจ้า")
            
        } else  {
//            print("Wrong!")
            wrongCount = wrongCount + 1
            playSound("sayno")
            ProgressHUD.showError("ผิดครับ")
        }
        if score > 9 {
            checkScore = true
        }
    }// end checkAnswer
    
    func startOver() {
        questionNumber = 0
        score = 0
        correctCount = 0
        wrongCount = 0
        limitTime = 60
        updateUI()
    }//end startOver

    func nextQuestion(){
        if questionNumber <= 19 {
            questionLabel?.text = allQuestion.list[questionNumber].questionText
        }else{
            print("end of question")
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let nextPage = storyBoard.instantiateViewController(withIdentifier: "scoreP") as! ViewController
//            self.present(nextPage, animated: true, completion: nil)
            
            
            let alert = UIAlertController(title: "AWSOME", message: "คุณตอบคำถามครบแล้ว ต้องการเล่นอีกครั้ง? คะแนนของคุณคือ \(score)", preferredStyle: .alert)

            let restartAction = UIAlertAction( title: "Restart", style: .default, handler:{
                UIAlertAction in self.startOver()

            })

            alert.addAction(restartAction)

            present(alert,animated: true,completion: nil)
            
        }
    }
    
    func updateUI(){
        progressBar?.frame.size.width = (view.frame.size.width / 20)
            * CGFloat(questionNumber)
        
        numQuestionLabel?.text = String(questionNumber) + "/20"
         yourScoreShow?.text = "คะแนนของคุณคือ : " + String(score)

        nextQuestion()
        
        checkForShowImage()
  
    }
    
    func checkForShowImage(){
        if score>=16 && score<=20{
            imgShow?.image = UIImage (named: "smile" )
        }
        else if score>=11 && score<=15{
            imgShow?.image = UIImage (named: "shy" )
        }
        else if score>=0 && score<=10{
            imgShow?.image = UIImage (named: "cry" )
        }
    } //โชว์ไอคอนหน้า
    
    func playSound(_ playThis : String){
        let soundURL = Bundle.main.url(forResource: playThis, withExtension: "mp3")
        audioplayer = try! AVAudioPlayer(contentsOf: soundURL!)
        audioplayer.play()
    } //เล่นเสียตอนตอบ

    func changGift() {
        
        if checkRandom {
            randomGift = Int(arc4random_uniform(5))
            showGift.image = UIImage(named: giftImg[randomGift])
            
            if giftImg[randomGift] == giftImg[0]{
                showLabel.text = " รับแบรนด์ไปบำรุงสมองค่ะ "
            }
            else if giftImg[randomGift] == giftImg[1]{
                showLabel.text = " ลองไปฝึกเขียนฝึกอ่านดูนะคะ "
            }
            else if giftImg[randomGift] == giftImg[2]{
                showLabel.text = " เปิดอ่านเยอะๆเลยค่ะ ช่วยได้ "
            }
            else if giftImg[randomGift] == giftImg[3]{
                showLabel.text = " รับปากกาน่ารักๆไปเลยค่ะ "
            }
            else if giftImg[randomGift] == giftImg[4]{
                showLabel.text = " รับตั๋วเครื่องบินไปสถาบันภาษาไทยก่อนนะคะ "
            }
            
            checkRandom = false
        }
    } //สุ่มรางวัล
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        changGift()
    } //เขย่า
    
    
    @IBAction func goToSUm(_ sender: UIButton) {
        if checkScore {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextPage = storyBoard.instantiateViewController(withIdentifier: "Gift") as! ViewController
            self.present(nextPage, animated: true, completion: nil)
        }
    }

}//end class


