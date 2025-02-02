//
//  API.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/30/25.
//

import Combine
import Foundation

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

struct Token: Decodable {
	var access_token: String
	var token_type: String
	var expires_in: Double
	var scope: String
	var created_at: Double
}

enum NetworkError: Error {
	case unauthorised
	case timeout
	case serverError
	case invalidResponse(code_error: Int)
	case invalidUrl
}


class Network {
	var env_data : EnvDict = env_dict
	
	func GetToken() async throws {
		guard let url = URL(string: env_data.url_42 + "/oauth/token")
			else { throw NetworkError.invalidUrl }
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "POST"
		
		let token_body = "grant_type=client_credentials&client_id=\(env_data.uid_43)&client_secret=\(env_data.secret_42)"
		urlRequest.httpBody = token_body.data(using: String.Encoding.utf8)
		print("urlRequest:", urlRequest)
				
		let (data, response) = try await URLSession.shared.data(for: urlRequest)
			print ("Data:", data)
		guard (response as? HTTPURLResponse)?.statusCode == 200
		else { throw NetworkError.invalidResponse(code_error: (response as? HTTPURLResponse)?.statusCode ?? 500)}
		
		print ("Response:", response)
		let Token = try JSONDecoder().decode(Token.self, from: data)
		print("Async decodedFood", Token)
	}
}

