library label_marker;

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension AddExtension on Set<Marker> {
  Future<bool> addLabelMarker(LabelMarker labelMarker) async {
    bool result = false;
    await createCustomMarkerBitmap(
      labelMarker.label,
      backgroundColor: labelMarker.backgroundColor,
      textStyle: labelMarker.textStyle,
      removePointyTriangle: labelMarker.removePointyTriangle,
      borderRadius: labelMarker.borderRadius,
    ).then((value) {
      add(Marker(
        markerId: labelMarker.markerId,
        position: labelMarker.position,
        icon: value,
        alpha: labelMarker.alpha,
        anchor: labelMarker.anchor,
        consumeTapEvents: labelMarker.consumeTapEvents,
        draggable: labelMarker.draggable,
        flat: labelMarker.flat,
        infoWindow: labelMarker.infoWindow,
        rotation: labelMarker.rotation,
        visible: labelMarker.visible,
        zIndex: labelMarker.zIndex,
        onTap: labelMarker.onTap,
        onDragStart: labelMarker.onDragStart,
        onDrag: labelMarker.onDrag,
        onDragEnd: labelMarker.onDragEnd,
      ));
      result = true;
    });
    return (result);
  }
}

Future<BitmapDescriptor> createCustomMarkerBitmap(
  String title, {
  required TextStyle textStyle,
  Color backgroundColor = Colors.blueAccent,
  bool removePointyTriangle = false,
  double borderRadius = 10.0,
}) async {
  TextSpan span = TextSpan(
    style: textStyle,
    text: title,
  );
  TextPainter painter = TextPainter(
    text: span,
    textAlign: TextAlign.center,
    textDirection: ui.TextDirection.ltr,
  );
  painter.text = TextSpan(
    text: title.toString(),
    style: textStyle,
  );
  ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  Canvas canvas = Canvas(pictureRecorder);
  painter.layout();
  painter.paint(canvas, const Offset(20.0, 10.0));
  int textWidth = painter.width.toInt();
  int textHeight = painter.height.toInt();
  canvas.drawRRect(
    RRect.fromLTRBAndCorners(
      0,
      0,
      textWidth + 40,
      textHeight + 20,
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
    ),
    Paint()..color = backgroundColor,
  );
  if (!removePointyTriangle) {
    var arrowPath = Path();
    arrowPath.moveTo((textWidth + 40) / 2 - 15, textHeight + 20);
    arrowPath.lineTo((textWidth + 40) / 2, textHeight + 40);
    arrowPath.lineTo((textWidth + 40) / 2 + 15, textHeight + 20);
    arrowPath.close();
    canvas.drawPath(arrowPath, Paint()..color = backgroundColor);
  }
  painter.layout();
  painter.paint(canvas, const Offset(20.0, 10.0));
  ui.Picture p = pictureRecorder.endRecording();
  ByteData? pngBytes = await (await p.toImage(
          painter.width.toInt() + 40, painter.height.toInt() + 50))
      .toByteData(format: ui.ImageByteFormat.png);
  Uint8List data = Uint8List.view(pngBytes!.buffer);
  return BitmapDescriptor.fromBytes(data);
}

class LabelMarker {
  final String label;
  final MarkerId markerId;
  final LatLng position;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double alpha;
  final Offset anchor;
  final bool consumeTapEvents;
  final bool draggable;
  final bool flat;
  final BitmapDescriptor icon;
  final InfoWindow infoWindow;
  final double rotation;
  final bool visible;
  final double zIndex;
  final VoidCallback? onTap;
  final ValueChanged<LatLng>? onDragStart;
  final ValueChanged<LatLng>? onDragEnd;
  final ValueChanged<LatLng>? onDrag;
  final bool removePointyTriangle;

  /// New: Allows customization of the border radius
  final double borderRadius;

  LabelMarker({
    required this.label,
    required this.markerId,
    required this.position,
    this.backgroundColor = Colors.blueAccent,
    this.textStyle = const TextStyle(
      fontSize: 27.0,
      color: Colors.white,
      letterSpacing: 1.0,
      fontFamily: 'Roboto Bold',
    ),
    this.alpha = 1.0,
    this.anchor = const Offset(0.5, 1.0),
    this.consumeTapEvents = false,
    this.draggable = false,
    this.flat = false,
    this.icon = BitmapDescriptor.defaultMarker,
    this.infoWindow = InfoWindow.noText,
    this.rotation = 0.0,
    this.visible = true,
    this.zIndex = 0.0,
    this.onTap,
    this.onDrag,
    this.onDragStart,
    this.onDragEnd,
    this.removePointyTriangle = false,
    this.borderRadius = 10.0,
  });
}
