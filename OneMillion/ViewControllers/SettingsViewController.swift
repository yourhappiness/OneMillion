//
//  SettingsViewController.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 29/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import UIKit

/// Экран настроек игры
public class SettingsViewController: UIViewController {

  @IBOutlet weak var predeterminedSequenceButton: UIButton!
  @IBOutlet weak var randomSequenceButton: UIButton!
  
  private var game: Game = Game.shared
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    switch game.questionsSequence {
    case .predetermined:
      self.predeterminedSequenceButton.backgroundColor = .white
    case .random:
      self.randomSequenceButton.backgroundColor = .white
    }
  }

  @IBAction func predeterminedSequenceButtonPressed(_ sender: Any) {
    self.predeterminedSequenceButton.backgroundColor = .white
    self.randomSequenceButton.backgroundColor = .yellow
    let secondsToDelay = 0.5
    DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
      self.game.questionsSequence = .predetermined
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func randomSequenceButtonPressed(_ sender: Any) {
    self.randomSequenceButton.backgroundColor = .white
    self.predeterminedSequenceButton.backgroundColor = .yellow
    let secondsToDelay = 0.5
    DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
      self.game.questionsSequence = .random
      self.dismiss(animated: true, completion: nil)
    }
  }
  
}
