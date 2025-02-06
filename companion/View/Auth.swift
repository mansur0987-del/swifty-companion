//
//  Auth.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/30/25.
//

import SwiftUI

struct auth_view: View {
	@State var auth = false
	var body: some View {
		HStack {
			if auth == true {
				HStack {
					logout_button(auth :$auth)
					Spacer()
					profile_button()
				}
				.font(.system(size: 20, design: .rounded))
				.foregroundColor(.white)
				.padding()
			}
			else {
				login_button(auth: $auth)
			}
			
		}
		.frame(alignment: .bottom)
	}
}

struct logout_button: View {
	@Binding var auth : Bool
	var body: some View {
		Button {
			print("logout")
			auth.toggle()
		} label: {
			Text("Logout")
		}
		.padding(15)
		.background(.tertiary)
		.cornerRadius(40)
	}
}

struct profile_button: View {
	var body: some View {
		Button {
			print("User")
		} label: {
			Text("UserName")
		}
		.padding(15)
		.background(.tertiary)
		.cornerRadius(40)
	}
}

struct login_button: View {
	@Binding var auth : Bool
	
	var body: some View {
		Button {
			print("login")
			
						
			auth.toggle()
		} label: {
			Text("Login")
				.font(.system(size: 20, design: .rounded))
				.padding(15)
				.padding([.leading, .trailing], 15)
				.background(.tertiary)
				.foregroundColor(.white)
				.cornerRadius(40)
				.padding()
		}
	}
}

