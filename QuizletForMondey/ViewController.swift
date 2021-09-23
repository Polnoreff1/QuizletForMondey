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
    var currentCellBool: Bool = false
    var currentCellDict: Dictionary<String, Bool> = [:]
    private var array: [Dictionary<String, Bool>] = []
    var index = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(array)
    }

    override func viewWillAppear(_ animated: Bool) {
        //Вот тут я так понимаю надо брать резалты,хотя та функция которая возвращает резалты прописана, но возвращается разный результат
//        favItems = RealmService.shared.getFavouriteRecipe()
//        loadRecipes()
//        tableView.reloadData()
    }

    //MARK: - Override method
    
    
    
    //MARK: - IBAction
    @IBAction func AddNewTask(_ sender: UIBarButtonItem) {
        addAlertForNewItem { text in
            self.array.append([text : false])
            UserSettings.task = self.array
            self.tableView.reloadData()
        }
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
        for (key,value) in currentPair {
            cell.title.text = key
            cell.cellSwitch.isOn = value
            print("hello")
        }
        
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
                currentCellDict = array[indexPath.row]
                for (key,value) in currentCellDict {
                    currentCellString = key
                    currentCellBool = value
                }
                performSegue(withIdentifier: "showDesc", sender: nil)
                tableView.deselectRow(at: indexPath, animated: true)
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "showDesc" else { return }
            let dvc = segue.destination as? DescriptionViewController
            for (key,value) in currentCellDict {
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

extension ViewController {
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        array = UserSettings.task ?? []
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
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
        print(temp)
        print(array)
        UserSettings.task = array
    }
    
    
    
    
}
