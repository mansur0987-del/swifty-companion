//
//  Interfaces.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/31/25.
//

import Foundation

struct EnvDict : Codable {
	var uid_43 : String
	var secret_42 : String
	var url_42 :String
	
	init (uid_43: String, secret_42: String, url_42: String) {
		self.uid_43 = uid_43
		self.secret_42 = secret_42
		self.url_42 = url_42
	}
}
