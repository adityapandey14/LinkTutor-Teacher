import MapKit
import SwiftUI

struct MapViewExample: View {
    @Binding var searchString: String
    @Binding var selectedLocation: CLLocationCoordinate2D?

    var body: some View {
        VStack {
            TextField("Search", text: $searchString)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)

            MapView(searchString: $searchString, selectedLocation: $selectedLocation)
                .ignoresSafeArea()
        }
    }
}


struct MapView: UIViewRepresentable {
    @Binding var searchString: String
    @Binding var selectedLocation: CLLocationCoordinate2D?

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print("Center Coordinate: \(mapView.centerCoordinate)")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()

        // Set mapView properties, if needed

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchString

        let search = MKLocalSearch(request: searchRequest)

        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            uiView.setRegion(response.boundingRegion, animated: true)
            self.selectedLocation = response.boundingRegion.center
        }
    }
}

struct MapViewExample_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            
        }
    }
}
