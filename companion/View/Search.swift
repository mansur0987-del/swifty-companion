//
//  Search.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/30/25.
//

import SwiftUI

struct search_user: View {
	@Binding var network : Network
	@State var text_error: String = "Write login"
	@State var showDetailView = false
	@State var userName : String = ""
	@State var user : User?
	
	var body: some View {
		VStack{
			Image("42_logo")
				.padding([.top], 10)
				.frame(maxHeight: 200, alignment: .top)
			TextField ("User name", text: $userName)
				.font(.system(size: 20, weight: .semibold, design: .rounded))
				.padding()
				.background(.white)
				.frame(width: 300, alignment: .center)
				.cornerRadius(40)
			Button  {
				Task {
					self.user = nil
					text_error = ""
					
					if userName == "" {
						text_error = "Write login"
					}
					else {
						do {
							self.user = try await network.GetUserData(user_login: userName)
						}
						catch NetworkError.invalidResponse(code_error: 404) {
							text_error = "Couldn't Find Account"
						}
						catch {
							text_error = "Server error. Check internet connection."
						}
						userName = ""
					}
					showDetailView = text_error != "" ? true : self.user != nil ? true : false
					print("text_error", text_error)
				}
			} label: {
				HStack {
					Image(systemName: "magnifyingglass")
						.padding(1)
					Text("Search")
				}
				.font(.system(size: 20, design: .rounded))
				.padding(15)
				.background(.tertiary)
				.foregroundColor(.white)
				.cornerRadius(40)
				.frame(width: 300)
				.padding()
			}
		}
		
		
		.sheet(isPresented: $showDetailView) {
			VStack {
				if self.user?.login != nil{
					HStack {
						avatar(link: self.user?.image?.link)
						main_data(	login: self.user!.login,
									email: self.user!.email,
									first_name: self.user!.first_name,
									last_name: self.user!.last_name,
									wallet: self.user!.wallet)
					}
					Spacer()
					
				}
				else {
					error_view(text_error: text_error)

				}
			}
			.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: .infinity)
			.ignoresSafeArea(.all)
			.background(background_image())
		}
		.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: .infinity)
	}
}

struct error_view : View {
	@State var text_error : String
	var body: some View {
		Text(self.text_error)
			.padding()
			.foregroundColor(.white)
	}
}

struct avatar : View {
	@State var link : String?
	var body: some View {
		if (self.link != nil) {
			AsyncImage(url: URL(string: (link)!), scale: 4)
				.frame(maxWidth: 150, maxHeight: 150)
				.cornerRadius(100)
				.padding()
		}
		else {
			Image("default")
				.resizable()
				.frame(maxWidth: 150, maxHeight: 150)
				.cornerRadius(100)
				.padding()
		}
	}
}

struct main_data : View {
	@State var login : String
	@State var email : String
	@State var first_name: String
	@State var last_name: String
	@State var wallet: Int
	var body: some View {
		VStack (alignment: .leading, spacing: 2) {
			Text("Login: " + login)
			Text("Email:" + email)
				.overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .top)
			Text("Name: " + first_name + ", " + last_name)
				.overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .top)
			Text("Wallet: " + String(wallet) + " ₳")
				.overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .top)
		}
		.foregroundColor(.white)
		.font(.system(size: 17, weight: .semibold, design: .rounded))
		.padding()
	}
}
