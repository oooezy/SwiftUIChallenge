//
//  ContentView.swift
//  CustomCarouselSlider
//
//  Created by 이은지 on 2022/06/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State private var width: CGFloat?
    @State var scrolled = 0
    @State var contents = [
        Content(id: 0, image: "img1", offset: 0),
        Content(id: 1, image: "img2", offset: 0),
        Content(id: 2, image: "img3", offset: 0),
        Content(id: 3, image: "img4", offset: 0)
    ]
    
    var body: some View {
        
        VStack() {
            HStack {
                Button(action: {}) {
                    Image(systemName: "text.alignleft")
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "square.grid.2x2")
                        .foregroundColor(.white)
                }
            }
            .padding()
            
            HStack() {
                Text("Travel")
                    .font(.system(size: 40, weight: .bold))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            Spacer()
            
            ZStack() {
                ForEach(contents.reversed()) { item in
                    HStack {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: calculateWidth(), height:
                                        (UIScreen.main.bounds.height / 1.5) - CGFloat(item.id - scrolled) * 50)
                                .cornerRadius(15)

                        }
                        .offset(x: item.id - scrolled <= 2 ? CGFloat(item.id - scrolled) * 30 : 60)
                        
                        Spacer(minLength: 0)
                    }
                    .contentShape(Rectangle())
                    .offset(x: item.offset)
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation {
                            if value.translation.width < 0 && item.id != contents.last!.id {
                                contents[item.id].offset = value.translation.width
                            } else {
                                if item.id > 0 {
                                    contents[item.id - 1].offset = -(calculateWidth() + 60) + value.translation.width
                                }
                            }
                        }
                    }).onEnded({ value in
                        withAnimation {
                            if value.translation.width < 0  {
                                if -value.translation.width > 180 && item.id != contents.last!.id {
                                    contents[item.id].offset = -(calculateWidth() + 60)
                                    scrolled += 1
                                } else {
                                    contents[item.id].offset = 0
                                }
                            } else {
                                if item.id > 0 {
                                    if value.translation.width > 180 {
                                        contents[item.id - 1].offset = 0
                                        scrolled -= 1
                                    } else {
                                        contents[item.id - 1].offset = -(calculateWidth() + 60)
                                    }
                                }
                            }
                        
                        }
                    }))
                }
            }
            .frame(height: UIScreen.main.bounds.height / 1.5)
            .padding(.horizontal, 25)
                               
            Spacer()
        }
        
        .background(Color("Color"))
    }
    
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.main.bounds.width - 50
        let width  = screen - (2 * 30)
        
        return width
    }
}

struct Content: Identifiable {
    var id: Int
    var image: String
    var offset: CGFloat
}
