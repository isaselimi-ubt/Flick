import SwiftUI

struct BannerModifier: ViewModifier {
    
    struct BannerData: Identifiable {
        var id = UUID()
        var title: String
        var detail: String
    }
    
    @Binding var data: [BannerData]
    @State var timer: Timer? = nil
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if data.count >= 0 {
                ZStack {
                    ForEach(data, id: \.id) { bannerItem in
                        VStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {                                    Text(bannerItem.title)
                                    .bold()
                                    Text(bannerItem.detail)
                                        .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                                    
                                }
                                Spacer()
                            }
                            .foregroundColor(Color.black)
                            .padding(12)
                            .background(Blur())
                            .cornerRadius(8)
                            Spacer()
                        }
                        .offset(y: -10)
                        .padding()
                        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut)
                        .onTapGesture {
                            withAnimation {
                                let index = data.firstIndex{ $0.id == bannerItem.id }
                                data.remove(at: index!)
                            }
                        }
                        .onAppear(perform: {
                            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                                if data.count > 0 {
                                    data.removeAll { $0.id == bannerItem.id }
                                }
                            }
                        })
                    }
                }
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .animation(.easeInOut)
            }
        }
    }
}
