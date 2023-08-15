import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime takeLater(DateTime actualTime) {
  return actualTime.add(Duration(minutes: 5));
}

DateTime adjustMinute(DateTime medDate) {
  return medDate.add(Duration(seconds: 50));
}

DateTime setMonthly(DateTime medDate) {
  return medDate.add(Duration(days: 30));
}

DateTime setDaily(DateTime medDate) {
  return medDate.add(Duration(days: 1));
}

DateTime? setWeekly(
  String? desiredWeekday,
  DateTime? actualDate,
) {
  if (actualDate != null) {
    return actualDate;
  } else if (desiredWeekday != null) {
    late int desiredWeekdayInInt;
    int todayWeekDayInInt = DateTime.now().weekday;

    switch (desiredWeekday) {
      case 'Dom':
        desiredWeekdayInInt = 1;
        break;
      case 'Seg':
        desiredWeekdayInInt = 2;
        break;
      case 'Ter':
        desiredWeekdayInInt = 3;
        break;
      case 'Qua':
        desiredWeekdayInInt = 4;
        break;
      case 'Qui':
        desiredWeekdayInInt = 5;
        break;
      case 'Sex':
        desiredWeekdayInInt = 6;
        break;
      case 'Sab':
        desiredWeekdayInInt = 7;
        break;
    }

    int daysToAdd = (desiredWeekdayInInt - todayWeekDayInInt + 7) % 7;
    DateTime nextWeekday = DateTime.now().add(Duration(days: daysToAdd - 1));

    if (nextWeekday.isBefore(DateTime.now())) {
      nextWeekday = nextWeekday.add(Duration(days: 7));
    }

    return nextWeekday;
  }
}
