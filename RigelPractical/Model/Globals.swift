//
//  Globals.swift
//  RigelPractical
//
//  Created by My MAC on 2/2/20.
//  Copyright © 2020 Bhavi Technologies Ltd. All rights reserved.
//

import Foundation
import CoreData

// THIS GLOABAL CLASS IS USED TO DECLARE ALL VARIABLE GLOBALLY IN ONE PLACED AND USED IN ALL APPLICATION
struct Globals
{
    static var sharedInstance = Globals()
    
    var indexofQuestions = 0 // Main Index Variable to navigate questions
    var indexofSelectedQuestions = 0
    var indexofPreviousQuestions = 0
    var arrGlobalQuestionsList = [QuestionBankModel]() // Main global Array to Store all Questions Data
    
    var SelectedQuestionsValue = ""
    var arrCorrectAnswer = [String]()
    var arrWrongAnswer = [String]()
    var arrNotAttempt = [String]()
    
}
