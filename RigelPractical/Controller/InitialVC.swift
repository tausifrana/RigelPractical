//
//  InitialVC.swift
//  RigelPractical
//
//  Created by My MAC on 2/2/20.
//  Copyright © 2020 Bhavi Technologies Ltd. All rights reserved.
//

import UIKit

class InitialVC: BaseClass {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearCoreData()
        getQuestionList()
        loadQuestionsFromCoreData()
    }
    
    // FUNCTION TO ADD STATIC QUESTION TO CORE DATA
    func getQuestionList()
    {
        var globalQuestionList = [QuestionBankModel(Id: "1", question: "What is 2+2", answer: "4", option1: "4", option2: "8", option3: "6", option4: "10", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0")]
        
        globalQuestionList.append(QuestionBankModel(Id: "2", question: "Which of the following is the world’s largest and deepest ocean?", answer: "Pacific", option1: "Arctic", option2: "Atlantic", option3: "Pacific", option4: "Indian", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))
        
        globalQuestionList.append(QuestionBankModel(Id: "3", question: "Which of the following states is not located in the North?", answer: "Jharkhand", option1: "Delhi", option2: "Haryana", option3: "Jharkhand", option4: "Himachal Pradesh", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))

        
        globalQuestionList.append(QuestionBankModel(Id: "4", question: "Which is the largest coffee producing state of India?", answer: "Karnataka", option1: "Karnataka", option2: "Kerala", option3: "Tamil Nadu", option4: "Assam", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))

        
        globalQuestionList.append(QuestionBankModel(Id: "5", question: "Dandia' is a popular dance of..", answer: "Gujarat", option1: "Punjab", option2: "Tamil Nadu", option3: "Gujarat", option4: "Maharashtra", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))

        
        globalQuestionList.append(QuestionBankModel(Id: "6", question: "The National Anthem was first sung in the year..", answer: "1911", option1: "1911", option2: "1913", option3: "1936", option4: "1935", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))
        
        globalQuestionList.append(QuestionBankModel(Id: "7", question: "Who among the following is known as “The Saint of Gutters?", answer: "Mother Teresa", option1: "Baba Amte", option2: "Mother Teresa", option3: "Anna Hazare", option4: "None of these", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))

        
        globalQuestionList.append(QuestionBankModel(Id: "8", question: "In which country is the headquarters of the World Bank located?", answer: "USA", option1: "England", option2: "Russia", option3: "USA", option4: "Japan", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))

        
        globalQuestionList.append(QuestionBankModel(Id: "9", question: "'The most populous city in the world is..", answer: "Tokyo", option1: "Paris", option2: "London", option3: "Peking", option4: "Tokyo", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))

        globalQuestionList.append(QuestionBankModel(Id: "10", question: "Which is Latest Version of IOS?", answer: "13.3.1", option1: "13.3.1", option2: "12.4.1", option3: "10.3.3", option4: "10.15.1", submitedOption: "NA", submitedAnswer: "NA", prevIndex: "0"))


        for index in 0..<globalQuestionList.count {
            let objData = globalQuestionList[index]
            addQuestionsToCoreData(Id: objData.QuestionID,
                                   question: objData.Questions,
                                   answer: objData.QuestionAnswer,
                                   option1: objData.QueOption1,
                                   option2: objData.QueOption2,
                                   option3: objData.QueOption3,
                                   option4: objData.QueOption4,
                                   submitedOption: objData.SubmitedOption,
                                   submitedAnswer: objData.SubmitedAnswer,
                                   prevIndex: objData.PreviosIndex)
            
        }
    }
    
    @IBAction func btnStartQuiz(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: Constant.STORYBOARD.CLASS_NAME.HomeVC) as! HomeVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
