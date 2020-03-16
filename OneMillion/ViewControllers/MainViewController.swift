//
//  MainViewController.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 24/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import UIKit

/// Контроллер главного меню
public class MainViewController: UIViewController {
  
  override public func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func playButtonPressed(_ sender: Any) {
    let gameSession = GameSession()
    Game.shared.gameSession = gameSession
    guard let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameViewController")
      else {return}
    self.present(gameVC, animated: true, completion: nil)
  }
}

