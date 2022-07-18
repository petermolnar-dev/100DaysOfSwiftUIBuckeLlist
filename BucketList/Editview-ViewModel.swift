//
//  Editview-ViewModel.swift
//  BucketList
//
//  Created by Peter Molnar on 18/07/2022.
//

import Foundation

extension EditView {
    @MainActor class EditViewModel: ObservableObject {
        
        let location: Location
        
        @Published var name: String
        @Published var description: String
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        init(location: Location) {
            self.location = location
            
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // we got some data back
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                // success, conversion worke convert the array value into our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                // capturing any error
                loadingState = .failed
            }
        }
    }
}
