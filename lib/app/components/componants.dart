// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Components {
  // ignore: constant_identifier_names
  static const BASEURL = 'https://fakestoreapi.com';
  static DefaultFormFeild({var Controller, var label, Widget? icon}) =>
      TextFormField(
        controller: Controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
}
