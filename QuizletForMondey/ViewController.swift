//
//  ViewController.swift
//  QuizletForMondey
//
//  Created by Андрей  on 20.09.2021.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Property
    private var currentCellString: String = ""
    var currentCellDict: Dictionary<String, Bool> = [:]
    private var array: [Dictionary<String, Bool>] = []
    private var index = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - IBAction
    @IBAction func AddNewTask(_ sender: UIBarButtonItem) {
        addAlertForNewItem { text in
            self.array.append([text : false])
            UserSettings.task = self.array
            self.tableView.reloadData()
        }
        setupUI()
    }
}

    //MARK: - TableDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        let currentPair = array[indexPath.row]
        currentPair.forEach { key,value in
            cell.title.text = key
            cell.cellSwitch.isOn = value
            switch cell.cellSwitch.isOn {
            case true:
                cell.imageCell.image = UIImage(imageLiteralResourceName: "trueDone")
            case false:
                cell.imageCell.image = UIImage(imageLiteralResourceName: "done")
            }
        }
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                index = indexPath.row
                currentCellDict = array[indexPath.row]
                performSegue(withIdentifier: "showDesc", sender: nil)
                tableView.deselectRow(at: indexPath, animated: true)
            }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let swipeDelete = UIContextualAction(style: .normal, title: "Delete") { (_,_,completionHandler) in
            self.tableView.performBatchUpdates({
                self.array.remove(at: indexPath.row)
                UserSettings.task = self.array
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }, completion: { _ in
                completionHandler(true)
            })

        }
        swipeDelete.backgroundColor = .white
        swipeDelete.image = #imageLiteral(resourceName: "trash")
        let conf1 = UISwipeActionsConfiguration(actions: [swipeDelete])
        conf1.performsFirstActionWithFullSwipe = false
        return conf1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "showDesc" else { return }
            let dvc = segue.destination as? DescriptionViewController
            currentCellDict.forEach { key,value in
                dvc?.taskStr = key
                dvc?.tempState = value
            }
            dvc!.closure = {
            self.array = UserSettings.task
            self.tableView.reloadData()
            }
            dvc!.closureForSwitch = {
            self.currentCellDict.forEach { key,value in
                var tempState = value
                    tempState.toggle()
                self.currentCellDict.updateValue(tempState, forKey: key)
            }
            self.array.remove(at: self.index)
            self.array.insert(self.currentCellDict, at: self.index)
            UserSettings.task = self.array
        }
    }
}

private extension ViewController {
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        array = UserSettings.task ?? []
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        tableView.rowHeight  = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
}


extension ViewController: CustomTVCDelegate {
    
    func switchIsPushed(cell: UITableViewCell) {
        let idexPath = self.tableView.indexPath(for: cell)
        var temp = array[idexPath!.row]
        temp.forEach { key,value in
            var tempState = value
                tempState.toggle()
            temp.updateValue(tempState, forKey: key)
        }
        array.remove(at: idexPath!.row)
        array.insert(temp, at: idexPath!.row)
        UserSettings.task = array
    }
}
