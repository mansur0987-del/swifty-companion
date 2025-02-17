//
//  API.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/30/25.
//

import Combine
import Foundation
import Security

var env_dict : EnvDict {
	get {
		guard let infoDictionary = Bundle.main.infoDictionary as? NSDictionary else {
			fatalError("NOT FOUND CONFIG")
		}
		guard let tmp_uid = infoDictionary["UID_42"] as? String, infoDictionary["UID_42"] as! String != ""  else {
			fatalError("NOT FOUND UID_42")
		}
		guard let tmp_secret = infoDictionary["SECRET_42"] as? String, infoDictionary["SECRET_42"] as! String != "" else {
			fatalError("NOT FOUND SECRET_42")
		}
		guard let tmp_url = infoDictionary["URL_42"] as? String, infoDictionary["URL_42"] as! String != "" else {
			fatalError("NOT FOUND URL_42")
		}
		let envDictionary = EnvDict(uid_43: tmp_uid, secret_42: tmp_secret, url_42: tmp_url)
		return envDictionary
	}
}

enum NetworkError: Error {
	case unauthorised
	case timeout
	case serverError
	case invalidResponse(code_error: Int)
	case invalidUrl
}

class Network : ObservableObject {
	var env_data : EnvDict = env_dict
	var token = Token()
	
	func GetToken() async throws -> Token {
		print("func GetToken")
		guard let url = URL(string: env_data.url_42 + "/oauth/token")
		else { throw NetworkError.invalidUrl }
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "POST"
		
		let token_body = "grant_type=client_credentials&client_id=\(env_data.uid_43)&client_secret=\(env_data.secret_42)"
		urlRequest.httpBody = token_body.data(using: String.Encoding.utf8)
		
		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		guard (response as? HTTPURLResponse)?.statusCode == 200
		else { throw NetworkError.invalidResponse(code_error: (response as? HTTPURLResponse)?.statusCode ?? 500)}
		if let token = try? JSONDecoder().decode(Token.self, from: data){
			UserDefaults.standard.set(data, forKey: "Token_data")
			UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "Token_date")
			return token
		}
		throw NetworkError.serverError
	}
	
	func CheckToken() async throws {
		print("func CheckToken")
		if let token_data = UserDefaults.standard.object(forKey: "Token_data") as? Data,
		   let token = try? JSONDecoder().decode(Token.self, from: token_data),
		   Date().timeIntervalSince1970 - UserDefaults.standard.double(forKey: "Token_date") < token.expires_in - 10 {
			self.token = token
		}
		else { self.token = try await GetToken() }
	}
		
	func GetUserData(user_login : String) async throws -> User {
		print("func GetUserData")
		try await CheckToken()
		guard let url = URL(string: env_data.url_42 + "/v2/users/" + user_login.lowercased())
		else { throw NetworkError.invalidUrl }
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "GET"
		urlRequest.setValue("Bearer " + token.access_token, forHTTPHeaderField: "Authorization")
		
		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		guard (response as? HTTPURLResponse)?.statusCode == 200
		else { throw NetworkError.invalidResponse(code_error: (response as? HTTPURLResponse)?.statusCode ?? 500)}
		if let users = try? JSONDecoder().decode(User.self, from: data) {
			return users
		}
		throw NetworkError.serverError
	}

}
