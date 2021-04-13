//
//  DetailNotesViewController.swift
//  Demo Task by Sarvesh
//
//  Created by Nilesh Vernekar on 10/04/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import CoreData

protocol callNotes {
    func displayDetail(title: String,desc:String)
}


class DetailNotesViewController: UIViewController {

    @IBOutlet var titlefield: UITextField!
     @IBOutlet var notesDetail: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var delegate: callNotes?
    var notesData: Notes?
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titlefield.text = notesData?.titleT ?? ""
         self.notesDetail.text = notesData?.descT ?? ""

        self.titlefield.becomeFirstResponder()
        self.saveBtn.addTarget(self, action: #selector(saveBtnPressd), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func saveBtnPressd(sender: UIButton){
        if let test = titlefield.text, !test.isEmpty, !notesDetail.text.isEmpty {
            delegate?.displayDetail(title: test, desc: notesDetail.text)
            self.navigationController?.popViewController(animated: true)
//            completion?(test,notesDetail.text)
        } else {
            alert()
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "Notes", message: "Cannot Save empty Notes.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
}
