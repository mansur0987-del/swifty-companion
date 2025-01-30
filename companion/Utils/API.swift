//
//  API.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/30/25.
//

import Foundation

var infoDictionary : NSDictionary {
	get {
		guard let infoDictionary = Bundle.main.infoDictionary as? NSDictionary else {
				fatalError("NOT FOUND CONFIG")
			}
		return infoDictionary
	}
}
