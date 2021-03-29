import 'dart:io';

import 'package:places/models/place.dart';
import 'package:places/widgets/location_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static final routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) async {
    _pickedLocation = PlaceLocation(longitude: lat, latitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(),
                    ImageInput(_selectedImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.fromHeight(50),
              primary: Theme.of(context).accentColor,
            ),
            // style: ButtonStyle(
            //   elevation: MaterialStateProperty.all(0),
            //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //   minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
            //   backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)
            // ),
          ),
        ],
      ),
    );
  }
}
