import SwiftUI
import MapKit


/*

Issue : AnnotationSheet was not displaying the proper annotation data from the array when clicked. 

Discussion : Initially the thought was the need to obtain the index number from the annotation being pushed so we could properly display the correct annotation. 
We attempted a few debugging steps which included printing a few debug lines in various places while using .onAppear and .onChange. 

After determining that what was happening was the application was attempting to display ALL of the annotation data within the arrays. 

Solution : Utilize the appropriate .sheet modifier with appropriate parameters. 
*/

	.sheet(item: <Binding<Identifiable?>, content: <(Identifiable) -> View>)

/*
We created an @State variable which pointed us to our Location array item. The ? at the end of Location creates it to be optional, 
meaning if we do not have a Location to return, the value is nil thus, don’t show anything.
*/
  @State var presentedLocation: Location?

/*
We then defined that presentedLocation is equal to place which is what we are wanting out of our MapAnnotation function. 
*/
  self.presentedLocation = place

/*
Then we utilize the sheet modifier in the following fashion, indicated that we want the sheet for the specific place (item) we selected.
*/

		.sheet(item: $presentedLocation) { place in
      AnnotationSheet(location: place)
   }

/* 
Below is what our body would look like with the appropriate changes.
*/
    var body: some View {
        Map(coordinateRegion: $coordinateRegion, annotationItems: dataModel.places) { place in
            MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                VStack {
                    Text(place.name)
                    Image(systemName: "thermometer")
                        .foregroundColor(Color.red)
                        .font(.system(size: 35))
                        .onTapGesture {
                            print("Annotation Tapped!")
                            self.presentedLocation = place
                        }
                }
            }
        }
        .ignoresSafeArea(.all)
        .sheet(item: $presentedLocation) { place in
            AnnotationSheet(location: place)
        }
