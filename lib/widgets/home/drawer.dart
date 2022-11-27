import 'package:flutter/material.dart';

const icon = Icon(Icons.arrow_back);

Drawer homeDrawer(
  Function draw,
  double width,
) =>
    Drawer(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: icon,
            alignment: Alignment.topLeft,
            onPressed: () => draw(),
          )
        ],
      ),
    );
