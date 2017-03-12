//
//  EventViewController.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/12/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: String(describing: EventViewCell.self), bundle: nil), forCellReuseIdentifier: "Cell")
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Sự kiện"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Api.getEvents(completion: {
            events in
            self.events = events
            self.tableView.reloadData()
        })
    }
}

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventViewCell
        let item = self.events[indexPath.row]
        cell.selectionStyle = .none
        cell.config(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
