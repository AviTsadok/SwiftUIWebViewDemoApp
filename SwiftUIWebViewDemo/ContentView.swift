import SwiftUI
import WebKit

struct ContentView: View {
    @State private var page = WebPage()
    
    var body: some View {
        NavigationStack {
            VStack {
                WebView(page)
                    .navigationTitle(page.title)
                Text(navigationKind)
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    if page.isLoading {
                        Button(action: { page.stopLoading() }) {
                            Image(systemName: "stop.fill")
                        }
                    } else {
                        Button(action: { page.reload() }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    }                                        
                }
            }
        }
        .onAppear {
            page.load(URLRequest(url: URL(string:"https://meliopayments.com" )!))
        }
    }
    
    var navigationKind: String {
        if let event = page.currentNavigationEvent {
            switch event.kind {
            case .committed: return "committed"
            case .finished: return "finished"
            case .receivedServerRedirect: return "receivedServerRedirect"
            case .startedProvisionalNavigation: return "startedProvisionalNavigation"
            default: return "other"
            }
        }
        return "no event"
    }
}

#Preview {
    ContentView()
}
