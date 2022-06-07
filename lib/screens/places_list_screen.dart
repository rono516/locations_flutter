// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:locations/screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        // builder: (BuildContext context, AsyncSnapshot<void> snapshot) {  },
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    //snapshot is the result the future returns
                    builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                        ? Center(
                            child: Text('No places yet! Add places'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              onTap: () {
                                //Go to details page
                              },
                            ),
                            itemCount: greatPlaces.items.length,
                          ),
                  ),
      ),
      // body: Consumer<GreatPlaces>(
      //   child: Center(
      //     child: Text('No places yet! Add some'),
      //   ),
      //   builder: (ctx, greatPlaces, child) =>
      //       greatPlaces.items.isEmpty  ? child : ListView(children: <Widget> []),
      // ),
    );
  }
}
