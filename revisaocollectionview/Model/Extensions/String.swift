//
//  String.swift
//  NavegacaoStoryboard
//
//  Created by Pedro Gomes on 18/10/21.
//

import UIKit


extension String {
    func toUIImage() -> UIImage? {
        guard let url = URL(string: self) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
