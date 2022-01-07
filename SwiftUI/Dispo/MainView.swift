import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @StateObject var vm: GiphyViewModel = GiphyViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.searchQuery.isEmpty ? vm.trending : vm.searchResults) { gif in
                    NavigationLink(destination: {
                        DetailView(gifID: gif.id)
                            .environmentObject(vm)
                    }, label: {
                        HStack(spacing: 12) {
                            AnimatedImage(url: gif.images.fixed_height.url)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80, alignment: .center)
                            Text(gif.title)
                        }
                    })
                }
            }
            .searchable(text: $vm.searchQuery)
            .onChange(of: vm.searchQuery) { value in
                if !value.isEmpty {
                    Task {
                        await vm.fetchQuery()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await vm.fetch()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
