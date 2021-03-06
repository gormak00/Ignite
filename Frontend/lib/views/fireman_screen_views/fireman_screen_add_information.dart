import 'package:flutter/material.dart';
import 'package:ignite/widgets/bottom_flushbar.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../models/hydrant.dart';
import '../../models/request.dart';
import '../../widgets/clipping_class.dart';
import '../../widgets/request_form.dart';
import '../../widgets/top_button_request.dart';

class FiremanAddInformation extends StatefulWidget {
  final Hydrant hydrant;
  final Request request;
  FiremanAddInformation({
    @required this.hydrant,
    @required this.request,
  });

  @override
  _FiremanAddInformationState createState() => _FiremanAddInformationState();
}

class _FiremanAddInformationState extends State<FiremanAddInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ThemeProvider.themeOf(context).id == "main"
          ? Colors.red[900]
          : Colors.grey[700],
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: ClippingClass(),
            child: Container(
              color: Colors.grey[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 42,
                    ),
                    child: TopButtonRequest(
                      context: context,
                      title: widget.hydrant.getCity() +
                          ", " +
                          widget.hydrant.getCap(),
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      subtitle: "Idrante in " +
                          widget.hydrant.getStreet() +
                          ", " +
                          widget.hydrant.getNumber(),
                      function: () {
                        new BottomFlushbar(
                          "Idrante nella città di " + widget.hydrant.getCity(),
                          "È possibile modificare i campi mancanti e poi confermare con il pulsante arancione in alto sulla destra",
                          Icon(
                            Icons.rate_review,
                            size: 28.0,
                            color: Colors.greenAccent,
                          ),
                          context,
                        ).show();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: RequestForm(
              isNewRequest: false,
              lat: widget.hydrant.getLat(),
              long: widget.hydrant.getLong(),
              oldHydrant: widget.hydrant,
              oldRequest: widget.request,
            ),
          ),
        ],
      ),
    );
  }
}
