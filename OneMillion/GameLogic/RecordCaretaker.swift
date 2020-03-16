//
//  RecordCaretaker.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 25/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Для записи результатов игры
final public class RecordsCaretaker {
  
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  private let key = "records"
  
  /// Сохранение результата игры
  ///
  /// - Parameter records: результат игры
  public func save(records: [Record]) {
    do {
      let data = try self.encoder.encode(records)
      UserDefaults.standard.set(data, forKey: key)
    } catch {
      print(error)
    }
  }
  
  /// Извлечение результата игры
  ///
  /// - Returns: результат игры
  public func retrieveRecords() -> [Record] {
    guard let data = UserDefaults.standard.data(forKey: key) else {
      return []
    }
    do {
      return try self.decoder.decode([Record].self, from: data)
    } catch {
      print(error)
      return []
    }
  }
}
