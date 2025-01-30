//
//  ContentView.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/26/25.
//

import SwiftUI

struct ContentView: View {
	@State var searchName = ""
	
	    var body: some View {
		VStack() {
			search_user(userName : $searchName)
			auth_view()
		}
		.ignoresSafeArea(edges: [.bottom])
		.background(background_image())
	}
}

#Preview {
    ContentView()
}



struct background_image: View {
	var body: some View {
		Image("bkgrnd")
			.resizable()
			.scaledToFill()
			.ignoresSafeArea(.all)
			.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
	}
}

struct search_user: View {
	@Binding var userName : String
	var body: some View {
		VStack{
			Image("42_logo")
				.padding([.top], 20)
				.frame(maxHeight: 200, alignment: .top)
			TextField ("User name", text: $userName)
				.font(.system(size: 20, weight: .semibold, design: .rounded))
				.padding()
				.background(.white)
				.frame(width: 300, alignment: .center)
				.cornerRadius(40)
			Button  {
				print (userName)
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
