//
//  ContentView.swift
//  companion
//
//  Created by Mansur Kakushkin on 1/26/25.
//

import SwiftUI

struct ContentView: View {
	@State var network = Network()
	@State var text_error: String = ""
	var body: some View {
		VStack() {
			if text_error == "" {
				search_user(network: $network)
			}
			else {
				Text(text_error)
			}
		}
		
		.ignoresSafeArea(edges: [.bottom])
		.background(background_image())
		.task {
			do {
				try await network.CheckToken()
			} catch {
				text_error = "System Error. Check internet connection."
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
