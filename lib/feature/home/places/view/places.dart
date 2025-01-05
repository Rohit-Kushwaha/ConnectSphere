import 'package:career_sphere/data/remote/network/network_api.dart';
import 'package:career_sphere/feature/home/places/bloc/bloc/places_bloc.dart';
import 'package:career_sphere/feature/home/places/repo/place_repo.dart';
import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  // List<Cart> arr = [];
  // late List<bool> isLiked;

  @override
  void initState() {
    super.initState();
    // Initialize `isLiked` with false values. Updated dynamically after API fetch.
    // isLiked = [];
  }

  @override
  void dispose() {
    NetworkApiService().cancelRequest();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PlacesBloc(PlacesRepoImpl())..add(FetchPlacesEvent(page: 0)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Places',
            style: merienda24(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: BlocConsumer<PlacesBloc, PlacesState>(
            listener: (context, state) {
              if (state is PlaceErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                ));
              }
            },
            builder: (context, state) {
              if (state is PlaceLoadedState) {
                // Initialize `isLiked` when places are loaded
                // if (isLiked.isEmpty) {
                //   isLiked = List<bool>.generate(
                //       state.place.places.length, (index) => false);
                // }
                

                return ListView.separated(
                  itemCount: state.place.places.length,
                  itemBuilder: (context, index) {
                    var place = state.place.places[index];
                    //  final isFavorite =
                    //   state.favorites.contains(place.id); 

                      // Check if the place is in favorites
    bool isFavorite = state.favorites.contains(Cart(
      id: place.id,
      title: place.name,
      location: place.location,
    ));
                    

                    return Container(
                      height: 130.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(width: 1)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              bottomLeft: Radius.circular(20.r),
                            ),
                            child: Image.network(
                              "https://cdn.pixabay.com/photo/2023/01/23/00/45/cat-7737618_1280.jpg",
                              width: 150.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.name,
                                    style: merienda14(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      Flexible(
                                        child: Text(
                                          place.location,
                                          style: merienda14(context),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star_border_outlined),
                                      Text(
                                        place.rating.toString(),
                                        style: merienda16(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: IconButton(
                                    
                                    onPressed: () {
                                     // Check favorite status
                                      // setState(() {
                                        // if (isLiked[index]) {
                                        //   // Remove from arr if already liked
                                        //   arr.removeWhere((item) =>
                                        //       item.title == place.name &&
                                        //       item.location == place.location);
                                        // } else {
                                        //   // Add to arr if not liked
                                        //   arr.add(Cart(
                                        //       title: place.name,
                                        //       location: place.location));
                                        // }
                                        // Toggle the like state
                                        // isLiked[index] = !isLiked[index];
                                      // });
                            //           context
                            // .read<PlacesBloc>()
                            // .add(ToggleFavoriteEvent(placeId: place.id));

                             context
                            .read<PlacesBloc>()
                            .add(ToggleFavoriteEvent(cart: 
                              Cart(id : place.id,title: place.name, location: place.location)
                            ));
                                      // debugPrint('Updated arr: $arr');
                                    },
                                    icon: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,

                                      // isLiked[index]
                                      //     ? Icons.favorite
                                      //     : Icons.favorite_border,
                                      // color: isLiked[index]
                                      //     ? Colors.red
                                      //     : Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.h);
                  },
                );
              }
              if (state is PlaceLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              return const Text('Something unexpected');
            },
          ),
        ),
      ),
    );
  }
}

class Cart {
  var id;
  final String title;
  final String location;

  Cart({required this.id,required this.title, required this.location});


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cart && other.id == id && other.title == title && other.location == location;
  }

  @override
  int get hashCode => title.hashCode ^ location.hashCode;

  @override
  String toString() {
    return 'Cart(id: $id, title: $title, location: $location)';
  }
}
