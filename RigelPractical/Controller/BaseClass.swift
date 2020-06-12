//
//  BaseClass.swift
//  RigelPractical
//
//  Created by My MAC on 2/2/20.
//  Copyright © 2020 Bhavi Technologies Ltd. All rights reserved.
//

import UIKit
import CoreData


// THIS IS BASE CLASS WHERE ALL METHODS ARE DECLARE IN ONE PLACE AND DIRECTLY CALL BY INHERITING THIS CLASS (INHERITANCE CONCEPT)
class BaseClass: UIViewController {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext: NSManagedObjectContext!
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "QuestionBank")
    var fetchResult: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // FUNCTION TO ADD DATA TO CORE DATABASE
    func addQuestionsToCoreData(Id: String, question: String, answer : String, option1: String, option2: String, option3: String, option4: String, submitedOption: String, submitedAnswer: String, prevIndex: String)
    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "QuestionBank", in: managedContext)!
        let objData = NSManagedObject(entity: entity,insertInto: managedContext)
        
        objData.setValue(Id, forKeyPath: "questionID")
        objData.setValue(question, forKeyPath: "question")
        objData.setValue(answer, forKeyPath: "answer")
        objData.setValue(option1, forKeyPath: "option1")
        objData.setValue(option2, forKeyPath: "option2")
        objData.setValue(option3, forKeyPath: "option3")
        objData.setValue(option4, forKeyPath: "option4")
        objData.setValue(submitedOption, forKeyPath: "submitedOption")
        objData.setValue(submitedAnswer, forKeyPath: "submitedAnswer")
        objData.setValue(prevIndex, forKeyPath: "previousIndex")

        do
        {
            try managedContext.save()
           // print("RECORD SAVE SUCCESSFULLY")
        }
        catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // FUNCTION TO RETRIVED DATA FROM CORE DATA
    func loadQuestionsFromCoreData()
    {
        Globals.sharedInstance.arrGlobalQuestionsList.removeAll()
        Globals.sharedInstance.arrCorrectAnswer.removeAll()
        Globals.sharedInstance.arrWrongAnswer.removeAll()
        Globals.sharedInstance.arrNotAttempt.removeAll()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext =  appDelegate.persistentContainer.viewContext
        
        do {
            
            fetchResult = try managedContext.fetch(fetchRequest)
            
            for i in 0 ..< fetchResult.count
            {
                let objData = fetchResult[i]
                let questionID =  objData.value(forKeyPath: "questionID") as! String
                let question =  objData.value(forKeyPath: "question") as! String
                let answer = objData.value(forKeyPath: "answer") as! String
                let option1 = objData.value(forKeyPath: "option1") as! String
                let option2 = objData.value(forKeyPath: "option2") as! String
                let option3 = objData.value(forKeyPath: "option3") as! String
                let option4 = objData.value(forKeyPath: "option4") as! String
                let submitedOption = objData.value(forKeyPath: "submitedOption") as! String
                let submitedAnswer = objData.value(forKeyPath: "submitedAnswer") as! String
                let previousIndex = objData.value(forKeyPath: "previousIndex") as! String

                Globals.sharedInstance.arrGlobalQuestionsList.append(QuestionBankModel(Id: questionID, question: question, answer: answer, option1: option1, option2: option2, option3: option3, option4: option4, submitedOption: submitedOption, submitedAnswer: submitedAnswer, prevIndex: previousIndex))
                    // print("TOTAL ARRAY COUNT",Globals.sharedInstance.arrGlobalQuestionsList.count)
            }
        }
        catch let error as NSError
        {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // FUNCTION TO UPDATE DATA TO CORE DATABASE

    func updateCoreData(UpdateRecordID: String, submitedOption: String, submitedAnswer: String, prevIndex: String)
       {
           appDelegate = UIApplication.shared.delegate as! AppDelegate
           managedContext =  appDelegate.persistentContainer.viewContext
           let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "QuestionBank")
           let predicate = NSPredicate(format: "questionID = '\(UpdateRecordID)'")
           fetchRequest.predicate = predicate
           do
           {
               let object = try managedContext.fetch(fetchRequest)
               if object.count == 1
               {
                   let objData = object.first as! NSManagedObject
                   objData.setValue(submitedOption, forKeyPath: "submitedOption")
                   objData.setValue(submitedAnswer, forKeyPath: "submitedAnswer")
                   objData.setValue(prevIndex, forKeyPath: "previousIndex")

                   do
                   {
                       try managedContext.save()
                       print("RECORD UPDATE SUCCESSFULLY")
                   }
                   catch
                   {
                       print(error)
                   }
               }
           }
           catch
           {
               print(error)
           }
       }
    
    // FUNCTION TO CLEAR CORE DATA
    func clearCoreData() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionBank")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do
        {
            print("CORE DATA CLEAR")
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    
    // ALERT FUNCTION
    func ShowAlert(title: String, Message: String)
       {
           let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                 switch action.style{
                 case .default:
                       print("default")

                 case .cancel:
                       print("cancel")

                 case .destructive:
                       print("destructive")

           }}))
           self.present(alert, animated: true, completion: nil)

       }
}
