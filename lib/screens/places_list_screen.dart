import 'package:flutter/material.dart';
import 'package:native_device_app/providers/great_places.dart';
import 'package:native_device_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  builder: (ctx, greatPlacesData, ch) =>
                      greatPlacesData.items.length <= 0
                          ? ch!
                          : ListView.builder(
                              itemCount: greatPlacesData.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlacesData.items[i].image),
                                ),
                                title: Text(greatPlacesData.items[i].title),
                                onTap: () {
                                  // Go to detail page
                                },
                              ),
                            ),
                  child: Center(
                    child: const Text('Got no places yet, start adding some'),
                  ),
                ),
        ));
  }
}
