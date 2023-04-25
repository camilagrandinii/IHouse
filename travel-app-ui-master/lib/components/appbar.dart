import 'package:flutter/material.dart';
import 'package:travelappui/constants/constants.dart';

// ignore: non_constant_identifier_names
AppBar HomeAppBar = AppBar(
  backgroundColor: kAppBarBackground,
  title: Center(
      child: Text(
    "IHouse Stats",
    style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
  )),
  leading: PopupMenuButton(
    offset: Offset.fromDirection(2, 58),
    onSelected: (value){

    },
    icon: Icon(Icons.menu),
    itemBuilder: (context) {
      return kAppBarMenuOptions
          .map(
            (option) => PopupMenuItem(
              value: option,
              child: Container(
                width: 120,
                child: Text(option, style: TextStyle(color: Colors.black),),
              ),
            ),
          )
          .toList();
    },
  ),
  actions: [
    IconButton(
        icon: Icon(
          Icons.account_circle,
          size: 20,
        ),
        onPressed: () {
          
        })
  ],
);
