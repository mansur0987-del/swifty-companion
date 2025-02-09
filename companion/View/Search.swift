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
							if (self.user == nil) {
								text_error = "Couldn't Find Account"
							}
						}
						catch NetworkError.invalidResponse(code_error: 404) {
							text_error = "Couldn't Find Account"
						}
						catch {
							text_error = "Server error"
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
						Text(self.user!.login)
							.foregroundColor(.white)
					}
					else {
						Text(text_error)
							.padding()
							.foregroundColor(.white)
					}
				}
				.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: .infinity)
				.ignoresSafeArea(.all)
				.background(background_image())
			}
		.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: .infinity)
		
		
		
	}
}
