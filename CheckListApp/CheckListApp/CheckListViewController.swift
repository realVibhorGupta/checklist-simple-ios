//
//  ViewController.swift
//  CheckListApp
//
//  Created by Vibhor Gupta on 2/26/19.
//  Copyright © 2019 Vibhor Gupta. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController  , AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }

    func addItemViewControllerDidCancel(_ controller: AddItemViewController, didFinishAdding item: CheckListItem) {

        let newIndex = itemsArray.count //ccreate neew indexx

        itemsArray.append(item)//Append in thee array
        let indexPath = IndexPath(row: newIndex, section: 0) //tells thee path
        let indexPaths = [indexPath]//add it to array of indexpath
        tableView.insertRows(at: indexPaths , with: .automatic) //add UI
        navigationController?.popViewController(animated: true)
    }

    func addItemViewControllerDidCancel(_ controller: AddItemViewController, didFinishEditing item: CheckListItem) {

        if let index = itemsArray.firstIndex(of: item ){
            let indexPath = IndexPath(row: index , section : 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }

        }
        navigationController?.popViewController(animated: true)

    }
    

    var itemsArray : [CheckListItem]


    required init?(coder aDecoder: NSCoder) {
        itemsArray = [CheckListItem]()



        super.init(coder:aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellItem", for: indexPath)

        let item = itemsArray[indexPath.row]

        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)


        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell  = tableView.cellForRow(at: indexPath){
        let item = itemsArray[indexPath.row]

        item.toggleCheckMark()
        configureCheckmark(for: cell, with: item)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }


    func configureCheckmark(for cell : UITableViewCell , with item : CheckListItem)  {

        let label = cell.viewWithTag(1001) as! UILabel

        if item.checked {
            label.text = "√"
        }else{
            label.text = " "
        }
    }

    func configureText(for cell : UITableViewCell , with item : CheckListItem)  {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text

    }


    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let newRowIndex  = itemsArray.count
        let item = CheckListItem()
        item.checked = false
        item.text = "I am a hew row"
        itemsArray.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        itemsArray.remove(at: indexPath.row)

        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self

        }else if segue.identifier == "EditItem"{
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = itemsArray[indexPath.row]
            }
        }
    }
    
}


