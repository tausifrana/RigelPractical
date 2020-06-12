//
//  QuestionBank.swift
//  RigelPractical
//
//  Created by My MAC on 2/2/20.
//  Copyright © 2020 Bhavi Technologies Ltd. All rights reserved.
//

import Foundation


// THIS IS MODEL CLASS FOR ALL QUESTIONS DETAIL
class QuestionBankModel {

    let QuestionID : String
    let Questions : String
    let QuestionAnswer : String
    let QueOption1 : String
    let QueOption2 : String
    let QueOption3 : String
    let QueOption4 : String
    let SubmitedOption : String
    let SubmitedAnswer : String
    let PreviosIndex : String

    init(Id: String, question: String, answer : String, option1: String, option2: String, option3: String, option4: String, submitedOption: String, submitedAnswer: String, prevIndex: String) {
        
        QuestionID = Id
        Questions = question
        QuestionAnswer = answer
        QueOption1 = option1
        QueOption2 = option2
        QueOption3 = option3
        QueOption4 = option4
        SubmitedOption = submitedOption
        SubmitedAnswer = submitedAnswer
        PreviosIndex = prevIndex
    }
}
