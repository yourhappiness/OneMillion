//
//  Game.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 25/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Синглтон игры
public class Game {
  private init() {
    self.records = self.recordsCaretaker.retrieveRecords()
  }
  private let recordsCaretaker = RecordsCaretaker()
  
  static let shared = Game()
  /// Текущая игровая сессия
  public var gameSession: GameSession?
  /// Вариант последовательности вопросов в игре
  public var questionsSequence: QuestionsSequence = .predetermined
  
  private(set) var records: [Record] {
    didSet {
      self.recordsCaretaker.save(records: self.records)
    }
  }
  
  /// Добавление результата игры
  ///
  /// - Parameter record: результат игры
  public func addRecord(_ record: Record) {
    self.records.append(record)
  }
  
  /// Очистка результатов игры
  public func clearRecords() {
    self.records = []
  }
}
