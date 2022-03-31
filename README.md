A package to create and use Google Maps marker with label text; the easiest and most efficient way.
<p align="center">
  <a href="https://pub.dartlang.org/packages/equatable">
    <img alt="Pub Package" src="https://img.shields.io/badge/version-0.0.1-green">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img alt="MIT License" src="https://img.shields.io/badge/License-MIT-blue.svg">
  </a>
</p>

## Features
<p align = "center">
<img src="https://github.com/NirmalScaria/label_marker/blob/main/assets/label_marker.jpg?raw=true" width="80%" alt="logo" />
    </p>
    
Use this app in your Flutter app to:

* Include marker with text in flutter app
* Customise the background colour of the label
* Customise the font style of the label
* Implement any other functionality that you could do with normal markers

## Getting started

1. Do the basic setup for having Google Maps
2. Create a Set of normal markers (Set<Marker>) and assign it as markers parameter of Google Maps widget
3. Import this package; label_marker, and call addLabelMarker() function on the Set of markers when you want to add a label marker.
4. Pass a LabelMarker widget, (created by giving required parameters, ie, label, position and markerId) to the above function. (See example.)
5. Remember to call setState using 'then' keyword on the addLabelMarker() function.

## Usage

```
markers.addLabelMarker(LabelMarker(
    label: "TextToShow",
    markerId: MarkerId("idString"),
    position: LatLng(10.0, 11.0),
    backgroundColor: Colors.green,
    )).then((value) {
    setState(() {});
    },
);
```

## Additional information

This was done alone and contributions are absolutely welcome. Any idea or suggestion to remove the need of setState after the function manually called, would be most appreciated. 

Enjoy the package. Develop something beautiful.
