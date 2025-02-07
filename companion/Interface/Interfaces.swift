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

struct Token: Decodable {
	var access_token: String
	var token_type: String
	var expires_in: Double
	var scope: String
	var created_at: Double
	
	init() {
		self.access_token = ""
		self.token_type = ""
		self.expires_in = 0
		self.scope = ""
		self.created_at = 0
	}
	
	init(access_token: String, token_type: String, expires_in: Double, scope: String, created_at: Double) {
		self.access_token = access_token
		self.token_type = token_type
		self.expires_in = expires_in
		self.scope = scope
		self.created_at = created_at
	}
}

struct User: Decodable {
	var id: Int
	var email: String
	var login: String
	var first_name: String
	var last_name: String
	var usual_full_name: String?
	var usual_first_name: String?
	var displayname: String?
	var image: ImageAPI?
}

struct ImageAPI: Decodable {
	var link: String?
	var versions_image: ImageVersion?
}

struct ImageVersion: Decodable {
	var small : String?
}
