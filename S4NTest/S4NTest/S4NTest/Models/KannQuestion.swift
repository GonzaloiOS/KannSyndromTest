//
//  KannQuestion.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import Foundation

enum KannQuestionType: Int, Codable {
    case headeache
    case alcohol
    case rangeAge
    case gender
    
    var path: String {
        switch self {
        case .alcohol: return "¿Bebe alcohol regularmente?"
        case .gender: return "¿Pertenece al genero femenino?"
        case .headeache: return "¿Sufre regularmente de dolor de cabeza?"
        case .rangeAge: return "¿Su edad está entre 20 y 30 años?"
        }
    }
}

class KannQuestion: Codable {
    let type: KannQuestionType
    var status: Bool
    
    init(type: KannQuestionType, status: Bool) {
        self.type = type
        self.status = status
    }
}
