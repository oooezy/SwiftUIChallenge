//
//  ContentView.swift
//  InteractionTabBar
//
//  Created by 이은지 on 2022/06/26.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = "house"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("BG")
                .ignoresSafeArea()
            TabBar(selectedTab: $selectedTab)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
