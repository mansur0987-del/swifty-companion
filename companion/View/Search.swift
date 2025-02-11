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
	@State private var selectedStructId: Int = 0
	@State var cursus : [Cursus] = []
	@State var selectedSkillsProjectId : Int = 0
	@State var typeViewData: [TypeViewData] = [
		TypeViewData(id: 0, name: "Skills"),
		TypeViewData(id: 1, name: "Projects")
	]
	
	
	var body: some View {
		VStack{
			Image("42_logo")
				.padding([.top], 10)
				.frame(maxHeight: 200, alignment: .top)
			TextField ("User name", text: $userName)
				.font(.system(size: 20, weight: .semibold, design: .rounded))
				.padding()
				.background(.tertiary)
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
							self.cursus = []
							self.user = try await network.GetUserData(user_login: userName)
							self.user?.cursus_users.forEach { Element in
								self.cursus.append(Cursus(id: Element.cursus.id, name: Element.cursus.name))
							}
							self.selectedStructId = self.cursus.first?.id ?? 0
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
					select_cursus(selectedStructId: $selectedStructId, cursus: cursus)
					
					@State var cursus_users: CursusUsers = self.user!.cursus_users.first(where: { Element in
						Element.cursus.id == selectedStructId
					})!
					
					@State var user_project: [UserProject] = self.user!.projects_users.filter({ Element in
						Element.cursus_ids.contains(selectedStructId)
					})
					
					level_data(cursus_users: $cursus_users)
					
					select_skills_projects(selectedSkillsProjectId: $selectedSkillsProjectId, typeViewData: typeViewData)
					
					if typeViewData.first(where: { Element in
						Element.id == selectedSkillsProjectId
					})!.name == "Skills" {
						skills_data(cursus_users: $cursus_users)
					}
					else if typeViewData.first(where: { Element in
						Element.id == selectedSkillsProjectId
					})!.name == "Projects" {
						projects_data(user_project: $user_project)
					}
					
				}
				else {
					error_view(text_error: text_error)

				}
			}
			.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: .infinity)
			.ignoresSafeArea(.all)
			.background(background_image())
			.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
			
		}
		.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: .infinity)
		.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
		
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
