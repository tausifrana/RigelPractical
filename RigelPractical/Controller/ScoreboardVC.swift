//
//  ScoreboardVC.swift
//  RigelPractical
//
//  Created by My MAC on 2/2/20.
//  Copyright © 2020 Bhavi Technologies Ltd. All rights reserved.
//

import UIKit
import CoreData



class ScoreboardVC: BaseClass {

    @IBOutlet weak var lblRightAnswer: UILabel!
    @IBOutlet weak var lblWrongAnswer: UILabel!
    @IBOutlet weak var lblNotAttempt: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var lblGreeting: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblGreeting.isHidden = true
        loadQuestionsFromCoreData()
        getResult()
    }
    
    @IBAction func btnPreviewAnswer(_ sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: Constant.STORYBOARD.CLASS_NAME.ReportVC) as! ReportVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // FUNCTION TO GET RESULT AND DISPLAY
    func getResult()
    {
        for i in 0...Globals.sharedInstance.arrGlobalQuestionsList.count - 1
        {
            let objData = Globals.sharedInstance.arrGlobalQuestionsList[i]
            print(objData.SubmitedOption)
            print(objData.SubmitedAnswer)
            
            if objData.SubmitedOption == "True"
            {
                Globals.sharedInstance.arrCorrectAnswer.append(objData.SubmitedOption)
            }
            else if objData.SubmitedOption == "False"
            {
                Globals.sharedInstance.arrWrongAnswer.append(objData.SubmitedOption)
            }
            else
            {
                Globals.sharedInstance.arrNotAttempt.append(objData.SubmitedOption)
            }
        }
        
        updateUI()
    }
    
    // FUNCTION TO UPDATE UI ACCORDING TO RESULT
    func updateUI()
    {
        DispatchQueue.main.async {
            self.lblRightAnswer.text = "\(Globals.sharedInstance.arrCorrectAnswer.count)"
            self.lblWrongAnswer.text = "\(Globals.sharedInstance.arrWrongAnswer.count)"
            self.lblNotAttempt.text = "\(Globals.sharedInstance.arrNotAttempt.count)"
            
            let value = self.calculatePercentage(value: Double(Globals.sharedInstance.arrCorrectAnswer.count), percentageVal: Double(Globals.sharedInstance.arrGlobalQuestionsList.count))
            self.lblPercentage.text = "\(String(format: "%.0f",value)) %"
            
            if value >= 80
            {
                self.lblGreeting.isHidden = false
                self.lblGreeting.text = "You Perform Excellent !!"
            }
        }
    }
    
    // FUNCTION TO CALCULATE PERCENTAGE
    func calculatePercentage(value : Double, percentageVal : Double)-> Double
    {
        let val = value / percentageVal * 100
        return val
    }
}
