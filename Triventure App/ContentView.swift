import SwiftUI

struct ContentView: View {
    
    var viewOptions = ["START", "JOIN", "CREATE"]
    
    @State private var globeSize: CGFloat = 250
    @State private var globePosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2.5)
    @State private var globeRotation: Double = 0
    @State private var shadowOpacity: Double = 1.0
    @State private var selectedView = "START"
    @State private var viewHeader = "Triventure"
    @State private var viewDesc = "En bra slogan"
    @State private var headerTxtColor = Color(.white)
    @State private var headerBgColor = Color("AppYellow")
    
    @State private var pin1: String = ""
    @State private var pin2: String = ""
    @State private var pin3: String = ""
    @State private var pin4: String = ""
    @State private var pin5: String = ""
    @State private var pin6: String = ""
    @FocusState private var focusedField: Int?
    
    var body: some View {
        ZStack {
            
            Color("AppYellow")
                .ignoresSafeArea()
            
            ZStack {
                Ellipse()
                    .fill(Color(red: 1.0, green: 0.6980392156862745, blue: 0.0, opacity: shadowOpacity))
                    .frame(width: globeSize * 0.65, height: globeSize * 0.14)
                    .offset(x: 0, y: globeSize * 0.28)
                
                Image("globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: globeSize, height: globeSize)
                    .position(globePosition)
                    .rotationEffect(Angle(degrees: globeRotation), anchor: .center)
                    .animation(.easeInOut(duration: 0.5), value: globeSize)
                    .animation(.easeInOut(duration: 0.5), value: globeRotation)
                    .animation(.easeInOut(duration: 0.5), value: globePosition)
                    .animation(.easeInOut(duration: 0.5), value: shadowOpacity)
            }
            
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "questionmark.circle")
                        Spacer()
                        Image(systemName: "person.crop.circle")
                    }
                    VStack {
                        Text(viewHeader)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        if !viewDesc.isEmpty {
                            Text(viewDesc)
                                .foregroundColor(Color("AppBlue"))
                                .font(.title3)
                        }
                    }
                }
                .padding()
                .foregroundColor(headerTxtColor)
                .font(.largeTitle)
                .background(
                    Color(headerBgColor)
                        .cornerRadius(20)
                        .edgesIgnoringSafeArea(.all)
                        .shadow(color: Color("AppYellowShadow"), radius: 20)
                    
                )
                
                
                
                
                switch selectedView {
                case "JOIN":
                    HStack {
                        Button {
                            selectedView = "START"
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .padding()
                        Spacer()
                    }
                    VStack {
                        Text("Gruppkod")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                        HStack(spacing: 10) {
                            Spacer()
                            
                            ForEach(0..<6, id: \.self) { index in
                                TextField("", text: Binding(
                                    get: {
                                        switch index {
                                        case 0: return pin1
                                        case 1: return pin2
                                        case 2: return pin3
                                        case 3: return pin4
                                        case 4: return pin5
                                        default: return pin6
                                        }
                                    },
                                    set: { newValue in
                                        switch index {
                                        case 0: pin1 = newValue
                                        case 1: pin2 = newValue
                                        case 2: pin3 = newValue
                                        case 3: pin4 = newValue
                                        case 4: pin5 = newValue
                                        default: pin6 = newValue
                                        }
                                    }
                                ))
                                .frame(height: 40)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color("AppYellowMuted"))
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .focused($focusedField, equals: index)
                                .onChange(of: Binding(
                                    get: {
                                        switch index {
                                        case 0: return pin1
                                        case 1: return pin2
                                        case 2: return pin3
                                        case 3: return pin4
                                        case 4: return pin5
                                        default: return pin6
                                        }
                                    },
                                    set: { _ in }
                                ).wrappedValue) {
                                    if (index == 0 && pin1.count == 1) ||
                                       (index == 1 && pin2.count == 1) ||
                                       (index == 2 && pin3.count == 1) ||
                                       (index == 3 && pin4.count == 1) ||
                                       (index == 4 && pin5.count == 1) ||
                                       (index == 5 && pin6.count == 1) {
                                        focusedField = index + 1
                                    }
                                }

                            }
                            
                            Spacer()
                        }
                        .font(.title3)
                        .onAppear {
                            focusedField = 0
                        }
                        
                        
                        Spacer()
                    }
                    
                    
                default:
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                    }
                    .padding(.vertical, 40)
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            selectedView = "JOIN"
                        } label: {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                Text("Gå med")
                                    .foregroundColor(Color("AppBlue"))
                            }
                        }
                        .frame(height: 50)
                        
                        Button {
                        } label: {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                Text("Skapa")
                                    .foregroundColor(Color("AppBlue"))
                            }
                        }
                        .frame(height: 50)
                    }
                    .font(.title)
                    .padding(.horizontal, 30.0)
                    .padding(.vertical, 60.0)
                    .bold()
                    
                    Spacer()
                }
            }
        }
        .onChange(of: selectedView) { oldValue, newValue in
            withAnimation(.easeInOut(duration: 0.5)) {
                if newValue == "START" {
                    globeSize = 250
                    globeRotation = 0
                    shadowOpacity = 1
                    globePosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2.5)
                    
                    headerBgColor = Color("AppYellow")
                    headerTxtColor = .white
                    viewDesc = "En bra slogan"
                } else {
                    globeSize = 450
                    globeRotation = -20
                    shadowOpacity = 0
                    globePosition = CGPoint(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 100)
                    headerBgColor = .white
                    headerTxtColor = Color("AppYellow")
                    
                    if newValue == "JOIN" {
                        viewHeader = "GÅ MED"
                        viewDesc = ""
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

