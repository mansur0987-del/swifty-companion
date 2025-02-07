//
//  Search.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/30/25.
//

import SwiftUI

struct search_user: View {
	@Binding var userName : String
	@Binding var network : Network
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
				print (userName == "" ? network.token.access_token : userName)
				Task {
					if userName != "" {
						do {
							let user = try await network.GetUserData(user_login: userName)
							print("user Vue", user)
						}
						catch {
							print("Error", error)
						}
				}
				
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
		.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: .infinity)
	}
}
