//
//  HomeVC.swift
//  RigelPractical
//
//  Created by My MAC on 2/2/20.
//  Copyright © 2020 Bhavi Technologies Ltd. All rights reserved.
//

import UIKit

class HomeVC: BaseClass {

    var countdownTimer: Timer!
    var totalTime = 59
    
    @IBOutlet weak var lblQuestionsNo: UILabel!
    @IBOutlet weak var lblTotalQuestions: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblQuestions: UILabel!
    
    @IBOutlet weak var btnOption1Outlet: UIButton!
    @IBOutlet weak var btnOption2Outlet: UIButton!
    @IBOutlet weak var btnOption3Outlet: UIButton!
    @IBOutlet weak var btnOption4Outlet: UIButton!
    @IBOutlet weak var lblOption1: UILabel!
    @IBOutlet weak var lblOption2: UILabel!
    @IBOutlet weak var lblOption3: UILabel!
    @IBOutlet weak var lblOption4: UILabel!
    
    @IBOutlet weak var btnNextOutlet: UIButton!
    @IBOutlet weak var btnPreviousOutlet: UIButton!
       
    override func viewDidLoad()
    {
        super.viewDidLoad()
        nextQuestion()
    }
       
    @IBAction func btnNextAction(_ sender: UIButton)
    {
        if Globals.sharedInstance.SelectedQuestionsValue != ""
        {
            if Globals.sharedInstance.SelectedQuestionsValue == Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QuestionAnswer
            {
                print("YOU HAVE SELECTED RIGHT ANSWER",Globals.sharedInstance.indexofSelectedQuestions)
                
                let recordID = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QuestionID
                updateCoreData(UpdateRecordID: recordID, submitedOption: "True", submitedAnswer: Globals.sharedInstance.SelectedQuestionsValue, prevIndex: String(Globals.sharedInstance.indexofSelectedQuestions))
                Globals.sharedInstance.indexofQuestions += 1
                resetController()
                nextQuestion()
            }
            else
            {
                print("YOU HAVE SELECTED WRONG ANSWER")
                
                print("Selected value is",Globals.sharedInstance.SelectedQuestionsValue)
                print("Selected Option is",Globals.sharedInstance.indexofSelectedQuestions)

                let recordID = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QuestionID
                updateCoreData(UpdateRecordID: recordID, submitedOption: "False", submitedAnswer: Globals.sharedInstance.SelectedQuestionsValue, prevIndex: String(Globals.sharedInstance.indexofSelectedQuestions))
                Globals.sharedInstance.indexofQuestions += 1
                resetController()
                nextQuestion()
            }
        }
        else
        {
            ShowAlert(title: Constant.DynamicAlerts.Alert, Message: Constant.DynamicAlerts.optionRequired)
        }
    }
    
    // FUNCTION TO GENERATE QUESION IN SERIES
    func nextQuestion() {
        startTimer()
        if Globals.sharedInstance.indexofQuestions <= Globals.sharedInstance.arrGlobalQuestionsList.count - 1
        {
            DispatchQueue.main.async {
                
                self.lblQuestionsNo.text = "Question \(Globals.sharedInstance.indexofQuestions + 1)"
                self.lblTotalQuestions.text = "\(Globals.sharedInstance.indexofQuestions + 1) / \(Globals.sharedInstance.arrGlobalQuestionsList.count)"
                self.lblQuestions.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].Questions
                self.lblOption1.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QueOption1
                self.lblOption2.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QueOption2
                self.lblOption3.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QueOption3
                self.lblOption4.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QueOption4
            }
        }
        else
        {
            endTimer()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: Constant.STORYBOARD.CLASS_NAME.ScoreboardVC) as! ScoreboardVC
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    // FUNCTION TO RESET VARIABLE AND CONTROLLER
    func resetController()
    {
        Globals.sharedInstance.indexofSelectedQuestions = 0
        Globals.sharedInstance.SelectedQuestionsValue = ""
        countdownTimer.invalidate()
        totalTime = 59
        self.lblTimer.text = "60 Seconds"
        btnOption1Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        btnOption2Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        btnOption3Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        btnOption4Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
    }
           
    @IBAction func btnOptionsAction(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            Globals.sharedInstance.indexofSelectedQuestions = 1
            Globals.sharedInstance.SelectedQuestionsValue = lblOption1.text!
            btnOption1Outlet.setImage(UIImage(named: "check.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        }
        else if sender.tag == 2
        {
            Globals.sharedInstance.indexofSelectedQuestions = 2
            Globals.sharedInstance.SelectedQuestionsValue = lblOption2.text!
            btnOption1Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "check.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        }
        else if sender.tag == 3
        {
            Globals.sharedInstance.indexofSelectedQuestions = 3
            Globals.sharedInstance.SelectedQuestionsValue = lblOption3.text!
            btnOption1Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "check.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        }
        else if sender.tag == 4
        {
            Globals.sharedInstance.indexofSelectedQuestions = 4
            Globals.sharedInstance.SelectedQuestionsValue = lblOption4.text!
            btnOption1Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "check.png"), for: .normal)
        }
    }
       
    func previousQuestion()
    {
        startTimer()
        Globals.sharedInstance.indexofQuestions -= 1
        if Globals.sharedInstance.indexofQuestions == -1
        {
            Globals.sharedInstance.indexofQuestions = 0
            ShowAlert(title: Constant.DynamicAlerts.Alert, Message: Constant.DynamicAlerts.firstRecord)
        }
        else
        {
            DispatchQueue.main.async {
                
                self.checkIndex()
                self.lblQuestionsNo.text = "Question \(Globals.sharedInstance.indexofQuestions + 1)"
                
                self.lblTotalQuestions.text = "\(Globals.sharedInstance.indexofQuestions + 1) / \(Globals.sharedInstance.arrGlobalQuestionsList.count)"
                
                self.lblQuestions.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].Questions
                self.lblOption1.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QueOption1
                self.lblOption2.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QueOption2
                self.lblOption3.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QueOption3
                self.lblOption4.text = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QueOption4
            }
            
        }
    }
       
    func checkIndex()
    {
        loadQuestionsFromCoreData()
        let SelectedIndex = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].PreviosIndex
        if SelectedIndex == "1"
        {
            Globals.sharedInstance.indexofSelectedQuestions = 1
            Globals.sharedInstance.SelectedQuestionsValue = lblOption1.text!
            btnOption1Outlet.setImage(UIImage(named: "check.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        }
        else if SelectedIndex == "2"
        {
            Globals.sharedInstance.indexofSelectedQuestions = 2
            Globals.sharedInstance.SelectedQuestionsValue = lblOption2.text!

            btnOption1Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "check.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        }
        else if SelectedIndex == "3"
        {
            Globals.sharedInstance.indexofSelectedQuestions = 3
            Globals.sharedInstance.SelectedQuestionsValue = lblOption3.text!

            btnOption1Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "check.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
        }
        else if SelectedIndex == "4"
        {
            Globals.sharedInstance.indexofSelectedQuestions = 4
            Globals.sharedInstance.SelectedQuestionsValue = lblOption4.text!

            btnOption1Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "check.png"), for: .normal)
        }
        else
        {
            Globals.sharedInstance.indexofSelectedQuestions = 0
            Globals.sharedInstance.SelectedQuestionsValue = "NA"

            btnOption1Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption2Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption3Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            btnOption4Outlet.setImage(UIImage(named: "uncheck.png"), for: .normal)
            
        }
    }
    
    @IBAction func btnPreviousAction(_ sender: UIButton)
    {
        resetController()
        previousQuestion()
    }
    
    @IBAction func btnSubmitQuiz(_ sender: UIButton)
    {
        let alertController = UIAlertController(title: Constant.DynamicAlerts.Alert, message: Constant.DynamicAlerts.submitQuiz, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) { UIAlertAction in
            
            self.resetController()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: Constant.STORYBOARD.CLASS_NAME.ScoreboardVC) as! ScoreboardVC
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        let cancelAction = UIAlertAction(title: "NOT NOW", style: UIAlertAction.Style.cancel) { UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // TIMER FUNCTION -->>>
    
    // FUNCTION TO START TIMER
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    // FUNCTION TO UPDATE TIME AT 1 INTERVAL
    @objc func updateTime()
    {
        self.lblTimer.text = "\(timeFormatted(totalTime))"
        if totalTime != 0
        {
            totalTime -= 1
        }
        else
        {
            endTimer()
        }
    }
    
    func endTimer()
    {
        if Globals.sharedInstance.indexofQuestions <= Globals.sharedInstance.arrGlobalQuestionsList.count - 1
        {
            let recordID = Globals.sharedInstance.arrGlobalQuestionsList[Globals.sharedInstance.indexofQuestions].QuestionID
            updateCoreData(UpdateRecordID: recordID, submitedOption: "NA", submitedAnswer: "NA", prevIndex: String("0"))
            Globals.sharedInstance.indexofQuestions += 1
            resetController()
            nextQuestion()
        }
        else
        {
            countdownTimer.invalidate()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return String(format: "%02d Seconds", seconds)
    }
}
