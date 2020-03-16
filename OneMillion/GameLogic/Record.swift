//
//  Record.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 25/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Результат игры
public struct Record: Codable {
  public let date: Date
  public let value: Double
}
