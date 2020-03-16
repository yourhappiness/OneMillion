//
//  RecordsTableViewController.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 30/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import UIKit

/// Контроллер для таблицы рекордов
public class RecordsTableViewController: UITableViewController {
  
  private let game: Game = Game.shared

  override public func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func closeButtonWasPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Table view data source

  override public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.game.records.count
  }

  override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
    let record = game.records[indexPath.row]
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    cell.textLabel?.text = dateFormatter.string(from: record.date)
    cell.detailTextLabel?.text = "\(record.value)"
    return cell
  }
}
