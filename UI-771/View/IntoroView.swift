//
//  IntoroView.swift
//  UI-771
//
//  Created by nyannyan0328 on 2022/10/18.
//

import SwiftUI

struct IntoroView: View {
    @State var showHome : Bool = false
    @State var currentIndex : Int = 0
      @Namespace var animation
    
    @State var showWorkThrought : Bool = false
    var body: some View {
        ZStack{
            
            if showHome{
                
                sampleHome()
                    .transition(.move(edge: .leading))
                
            }
            else{
                
                
                ZStack{
                    
                    Color("BG").ignoresSafeArea()
                    
                    intoroScreen()
                    
                    WorkThroughtScrreens()
                    
                    NavBar()
                    
                }
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: showWorkThrought)
                
            }
        }
    }
    @ViewBuilder
    func WorkThroughtScrreens ()->some View{
        
        let isLast = currentIndex == intros.count
        
        GeometryReader{
            
            let size = $0.size
         
            ZStack{
                
                ForEach(intros.indices ,id:\.self){index in
                    
                    ScrrenView(index: index, size: size)
                    
                    
                }
                
                WelcomView(index: intros.count, size: size)
                
                
            }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .overlay(alignment: .bottom) {
                  
                  Indicators()
                      .opacity(isLast ? 0 : 1)
                      .animation(.easeInOut(duration: 0.1), value: isLast)
                      .offset(y:-180)
              }
              .overlay(alignment: .bottom) {
                  
                  Image(systemName: "chevron.right")
                      .font(.title)
                      .foregroundColor(.white)
                      .padding(15)
                      .background{
                       Circle()
                              .fill(Color("Blue"))
                      }
                      .onTapGesture {
                          
                          currentIndex += 1
                          
                          
                      }
                      .offset(y:-90)
              }
              .overlay(alignment: .bottom) {
                  
                  ZStack(alignment: .bottom) {
                      
                      Image(systemName: "chevron.right")
                          .font(.title3.bold())
                          .scaleEffect(!isLast ? 1 : 0.001)
                          .opacity(!isLast ? 1 : 0.001)
                      
                      HStack{
                          
                          Text("Sigin up")
                              .font(.custom(sansRegular, fixedSize: 25))
                              .frame(maxWidth: .infinity,alignment: .leading)
                          
                          Image(systemName: "arrow.right")
                              .font(.title3.weight(.semibold))
                            
                      }
                      .padding(.horizontal,15)
                      .scaleEffect(isLast ? 1 : 0.001)
                      .frame(height: isLast ? nil : 0)
                      .opacity(isLast ? 1 : 0)
                      
                  }
                  .foregroundColor(.white)
                  .frame(width: isLast ? size.width / 1.5 : 55,height: isLast ? 50 : 55)
                  .background{
                   
                      RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ?  .continuous : .circular)
                          .fill(Color("Blue"))
                  }
                  .onTapGesture {
                      
                      if currentIndex == intros.count{
                          
                          showHome = true
                      }
                      else{
                          
                          currentIndex += 1
                      }
                  }
                  .offset(y:isLast ? -30 : -90)
                  .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: isLast)
                  
              }
              .overlay(alignment: .bottom) {
                  
                  HStack(spacing: 10) {
                      
                        Text("Already have an account")
                          .font(.custom(sansBold, fixedSize: 15))
                          .foregroundColor(.gray)
                      
                      Button("Login"){
                          
                          
                      }
                      .font(.custom(sansBold, fixedSize: 15))
                      .foregroundColor(Color("Blue"))
                  }
                  .offset(y:isLast ? -5 : 120)
                  .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: isLast)
            
                  
                  
                  
              }
              .offset(y:showWorkThrought ? 0 : size.height)
          
            
        }
        
    }
    @ViewBuilder
    func Indicators ()->some View{
     
        HStack(spacing:15){
            
            ForEach(intros.indices ,id:\.self){index in
                Circle()
                    .fill(.gray.opacity(0.2))
                    .frame(width:currentIndex == index ? 20 :  8,height: currentIndex == index ? 20 :  8)
                    .overlay {
                        
                        if currentIndex == index{
                            
                            Circle()
                                .fill(Color("Blue"))
                                 .frame(width: 20,height: 20)
                                 .matchedGeometryEffect(id: "INDICATRO", in: animation)
                            
                        }
                    }
                
            }
        }
        .animation(.easeInOut(duration: 0.5), value: currentIndex)
        
    }
    @ViewBuilder
    func ScrrenView(index : Int,size : CGSize)->some View{
        
        let intro = intros[index]
        
        VStack(spacing: 10) {
            
            Text(intro.title)
                .font(.custom(sansRegular, fixedSize: 30))
                .offset(x:-size.width * CGFloat((currentIndex - index)))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom(sansRegular, fixedSize: 13))
                .padding(.horizontal)
                .padding(.top,30)
                .offset(x:-size.width * CGFloat((currentIndex - index)))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .offset(x:-size.width * CGFloat((currentIndex - index)))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
        
              
                
        }
        .offset(y:-30)
        
        
    }
    
    @ViewBuilder
    func WelcomView(index : Int,size : CGSize)->some View{
        
     
        
        VStack(spacing: 10) {
            
            
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .offset(x:-size.width * CGFloat((currentIndex - index)))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
        
           
           
            
            Text(dummyText)
                .font(.custom(sansRegular, fixedSize: 13))
                .padding(.horizontal)
                .padding(.top,30)
                .offset(x:-size.width * CGFloat((currentIndex - index)))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
           
              
                
        }
        .offset(y:-30)
        
        
    }
    @ViewBuilder
    func NavBar ()->some View{
        
        let isLast = currentIndex == intros.count
        
        HStack{
            
            Button {
                
                if currentIndex > 0{
                    currentIndex -= 1
                }
                else{
                    
                    showWorkThrought.toggle()
                }
                
            } label: {
             
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(Color("Blue"))
                
            }
            
            Spacer()
            
            
            Button("Skip"){
                
                currentIndex = intros.count
                
            }
            .font(.custom(sansRegular, size: 15))
            .foregroundColor(Color("Blue"))
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
            
            
        }
        .padding(.top,10)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .padding(.horizontal,13)
        .offset(y:showWorkThrought ? 0 : -120)
        
        
    }
    @ViewBuilder
    func intoroScreen ()->some View{
        
        GeometryReader{
            
            let size = $0.size
         
            VStack(spacing: 15) {
                
                
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width,height: size.height / 2)
                
                
                 Text("Clera Head")
                    .font(.custom(sansBold, size: 20))
                    .kerning(1.5)
                    .padding(.top,20)
                
                  Text(dummyText)
                    .font(.caption)
                    .font(.custom(sansMedium, size: 15))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                
                Text("Let's Bigin")
                    .font(.custom(sansRegular, size: 20))
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background{
                            Capsule()
                            .fill(Color("Blue"))
                          
                    }
                    .onTapGesture {
                        
                        showWorkThrought.toggle()
                    }
                    .padding(.top,20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            .offset(y:showWorkThrought ? -size.height : 0)
        }
        .ignoresSafeArea()
        
    }
    
}

struct IntoroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct sampleHome : View{
    var body: some View{
        
        NavigationStack{
            
            Text("Home")
                .navigationTitle("Home")
        }
    }
}
