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
