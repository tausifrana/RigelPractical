//
//  ReportVC.swift
//  RigelPractical
//
//  Created by My MAC on 2/2/20.
//  Copyright © 2020 Bhavi Technologies Ltd. All rights reserved.
//

import UIKit

class CustomCell : UITableViewCell
{
    
    @IBOutlet weak var CellView: CustomView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblSubmitedAnswer: UILabel!
}

class ReportVC: BaseClass {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func btnGeneratePDF(_ sender: UIButton)
    {
        createPdfFromTableView()
    }
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // FUNCTION USED TO GENERATE PDF AND DOCUMENT ARE SAVED IN BELOW LOGGED PRINTED PATH
    func createPdfFromTableView()
    {
        let priorBounds: CGRect = self.tableView.bounds
        let fittedSize: CGSize = self.tableView.sizeThatFits(CGSize(width: priorBounds.size.width, height: self.tableView.contentSize.height))
        self.tableView.bounds = CGRect(x: 0, y: 0, width: fittedSize.width, height: fittedSize.height)
        self.tableView.reloadData()
        let pdfPageBounds: CGRect = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
        let pdfData: NSMutableData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        self.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let documentsFileName = documentDirectories! + "/" + "pdfName"
        pdfData.write(toFile: documentsFileName, atomically: true)
        print(documentsFileName)
    }
    
}
extension ReportVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Globals.sharedInstance.arrGlobalQuestionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        cell.selectionStyle = .none

        
        let objData = Globals.sharedInstance.arrGlobalQuestionsList[indexPath.row]
        cell.lblQuestion.text = "Question \(objData.QuestionID) : \(objData.Questions)"
        cell.lblAnswer.text = "Answer : \(objData.QuestionAnswer)"
        cell.lblSubmitedAnswer.text = "Given Answer : \(objData.SubmitedAnswer)"

        if objData.SubmitedOption == "True"
        {
            cell.CellView.backgroundColor = UIColor.systemGreen
            cell.lblQuestion.textColor = UIColor.white
            cell.lblAnswer.textColor = UIColor.white
            cell.lblSubmitedAnswer.textColor = UIColor.white
        }
        else if objData.SubmitedOption == "False"
        {
            cell.CellView.backgroundColor = UIColor.systemRed
            cell.lblQuestion.textColor = UIColor.white
            cell.lblAnswer.textColor = UIColor.white
            cell.lblSubmitedAnswer.textColor = UIColor.white
        }
        else
        {
            cell.CellView.backgroundColor = UIColor.white
            cell.lblQuestion.textColor = UIColor.darkGray
            cell.lblAnswer.textColor = UIColor.darkGray
            cell.lblSubmitedAnswer.textColor = UIColor.darkGray
        }
        
        return cell
    }
}
