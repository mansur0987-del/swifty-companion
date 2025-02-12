//
//  UserData.swift
//  companion
//
//  Created by Mansur Kakushkin on 2/12/25.
//

import SwiftUI

struct avatar : View {
	@State var link : String?
	var body: some View {
		if (self.link != nil) {
			AsyncImage(url: URL(string: (link)!), scale: 4)
				.frame(width: 120, height: 120)
				.cornerRadius(100)
				.padding()
		}
		else {
			Image("default")
				.resizable()
				.frame(width: 120, height: 120)
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
		VStack (alignment: .leading, spacing: 5) {
			Text("Login: " + login)
			Text("Email:" + email)
				.overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .top)
			Text("Name: " + first_name + ", " + last_name)
				.overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .top)
			Text("Wallet: " + String(wallet) + " ₳")
				.overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.gray), alignment: .top)
		}
		.frame(width: 170)
		.foregroundColor(.white)
		.font(.system(size: 20, weight: .semibold, design: .rounded))
		.padding()
	}
}

struct select_cursus : View {
	@Binding var selectedStructId : Int
	@State var cursus : [Cursus]
	var body: some View {
		Picker(selection:	$selectedStructId, label: Text(""), content: {
			ForEach(cursus, id: \.id) { Element in
				Text(Element.name)
			}
		})
		.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
		.accentColor(.white)
		
	}
}

struct level_data : View {
	@Binding var cursus_users : CursusUsers
	var body: some View {
		Text("Level: " + String(self.cursus_users.level))
			.foregroundColor(.white)
			.padding(.top)
			.frame(width: 100)
			.overlay(Rectangle()
				.frame(width: nil, height: 1, alignment: .top)
				.foregroundColor(Color.gray), alignment: .top)
	}
}

struct select_skills_projects : View {
	@Binding var selectedSkillsProjectId : Int
	@State var typeViewData : [TypeViewData]
	var body: some View {
		Picker(selection: $selectedSkillsProjectId, label: Text(""), content: {
			ForEach(typeViewData, id: \.id) { Element in
				Text(Element.name)
			}
		})
		.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
		.accentColor(.white)
		.overlay(Rectangle()
			.frame(width: nil, height: 1, alignment: .top)
			.foregroundColor(Color.gray), alignment: .top)
	}
}

struct skills_data : View {
	@Binding var cursus_users : CursusUsers
	var body: some View {
		List (self.cursus_users.skills, id: \.id) { skill in
			HStack {
				Text(skill.name)
					.padding(2)
					.frame(alignment: .leading)
				Spacer()
				Text(String(format: "%.2f", floor(skill.level * 100) / 100) + " lvl")
					.padding(2)
					.frame(alignment: .trailing)
			}
		}
		.font(.system(size: 18, design: .rounded))
		.padding(1)
		.frame(width: 400)
		.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
		.scrollContentBackground(.hidden)
	}
}

struct projects_data : View {
	@Binding var user_project: [UserProject]
	var body: some View {
		List (self.user_project, id: \.id) { project in
			HStack {
				Text(project.project.name)
					.frame(alignment: .leading)
					.padding(2)
				Spacer()
				if (project.final_mark != nil) {
					
					Text(String(project.final_mark!))
						.frame(alignment: .trailing)
						.padding(10)
						
				}
				Text(project.status)
					.frame(alignment: .trailing)
					.padding(2)
			}
		}
		.font(.system(size: 18, design: .rounded))
		.padding(1)
		.frame(width: 400)
		.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
		.scrollContentBackground(.hidden)
	}
}
