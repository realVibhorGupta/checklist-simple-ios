//
//  AddItemViewController.swift
//  CheckListApp
//
//  Created by Vibhor Gupta on 2/26/19.
//  Copyright © 2019 Vibhor Gupta. All rights reserved.
//

import UIKit
protocol AddItemViewControllerDelegate : class {

    func addItemViewControllerDidCancel(_ controller : AddItemViewController)
    func addItemViewControllerDidCancel(_ controller : AddItemViewController , didFinishAdding item: CheckListItem)
    func addItemViewControllerDidCancel(_ controller : AddItemViewController , didFinishEditing item: CheckListItem)

}
class AddItemViewController: UITableViewController ,UITextFieldDelegate {
   
    weak var delegate : AddItemViewControllerDelegate?
    var itemToEdit : CheckListItem? 
    @IBOutlet weak var canceelBarButton: UIBarButtonItem!

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var toDoTexxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        toDoTexxtField.delegate = self
        navigationItem.largeTitleDisplayMode = .never

        if let item = itemToEdit {
            title = "Edit Item"
            toDoTexxtField.text =  item.text
            doneBarButton.isEnabled = true

        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)

    }

   
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)

        if let itemToEdit = itemToEdit {
            itemToEdit.text = toDoTexxtField.text!
            delegate?.addItemViewControllerDidCancel(self, didFinishEditing: itemToEdit)
        }else{
        let item = CheckListItem()
        item.text = toDoTexxtField.text!
        item.checked = false
        delegate?.addItemViewControllerDidCancel(self, didFinishAdding: item )
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    //for keyboRD
    override func viewWillAppear(_ animated: Bool) {
        toDoTexxtField.becomeFirstResponder()
    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        toDoTexxtField.resignFirstResponder()
//        return true
//    }
//


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let oldText = toDoTexxtField.text!

        let stringRange = Range(range , in: oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)

        if newText.isEmpty {
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        return true

    }
}
