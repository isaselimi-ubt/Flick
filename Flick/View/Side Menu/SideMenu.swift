import SwiftUI

struct SideBarStack<SidebarContent: View, Content: View>: View {
    
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    
    init(sidebarWidth: CGFloat, showSidebar: Binding<Bool>, @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
        self.sidebarWidth = sidebarWidth
        self._showSidebar = showSidebar
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            sidebarContent
                .edgesIgnoringSafeArea(.top)
                .frame(width: sidebarWidth, alignment: .center)
                .offset(x: showSidebar ? 0 : -1 * sidebarWidth, y: 0)
                .animation(Animation.easeIn.speed(2))
                .zIndex(1)
            
            mainContent
                .overlay(
                    Group {
                        if showSidebar {
                            Color.black
                                .opacity(showSidebar ? 0.6 : 0)
                                .onTapGesture {
                                    self.showSidebar = false
                                }                        }
                        else {
                            Color.clear
                                .opacity(showSidebar ? 0 : 0)
                                .onTapGesture {
                                    self.showSidebar = false
                                }
                                .animation(.easeInOut.speed(2))
                        }
                    }
                    .ignoresSafeArea()
                )
                .animation(Animation.easeIn.speed(2))
            
        }
        .edgesIgnoringSafeArea([.horizontal, .bottom])
    }
}
