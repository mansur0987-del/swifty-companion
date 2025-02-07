//
//  ContentView.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/26/25.
//

import SwiftUI

struct ContentView: View {
	@State var searchName = ""
	@State var network = Network()
	var body: some View {
		VStack() {
			search_user(userName : $searchName, network: $network )
//			auth_view()
		}
		.ignoresSafeArea(edges: [.bottom])
		.background(background_image())
		.task {
			do {
				try await network.CheckToken()
			} catch {
				print("Error", error)
			}
		}
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
