import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as calc;

import 'package:dio/dio.dart';
import 'package:eti_chat/core/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

extension WidgetFunction on Widget {
  dismissKeyboard() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  showSuccessToast(
      {required final BuildContext context, required final String message}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.appDark,
      textColor: AppColors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  showErrorToast(
      {required final BuildContext context, required final String message}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.black,
      textColor: AppColors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  showUIDialog(BuildContext screenContext, Widget widget,
      {bool isDismissible = true, bool backDisable = false}) {
    showDialog(
        barrierDismissible: isDismissible,
        context: screenContext,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return !backDisable || kDebugMode;
              },
              child: widget);
        });
  }

  showProgressDialog(BuildContext context) {
    showDialog(
      barrierDismissible: kDebugMode,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: true,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 60,
                width: 60,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
            onPopInvoked: (isPoped) {
              // return Future.value(kDebugMode);
            });
      },
    );
  }

  showDebugToast(
      {required final BuildContext context, required final String message}) {
    Fluttertoast.showToast(
      msg: message,
      //textColor: AppColors.white,
      //backgroundColor: AppColors.app_color,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }
}


extension ErrorMerge on String {
  String? isImageUrl() {
    if (isNotEmpty && contains("http")) {
      return this;
    }
    return null;
  }

  toErrorMessage(List<String> data) {
    var error = "";
    for (var element in data) {
      error += "$element\n";
    }
    if (error.endsWith("\n")) {
      error = error.substring(0, error.length - 1);
    }
    return error;
  }

  String formatted(int? year, int? month, int? day) {
    String date = "$year-$month-$day";
    if (date.contains('null')) {
      return '';
    }
    final DateTime now = DateTime(year!, month!, day!);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidNumber() {
    return length == 10 && isNumber();
  }

  bool isNumber() {
    return RegExp(r'^[1-9]\d*$').hasMatch(this);
  }

  bool isVideo(String mediaType) {
    return mediaType.contains("video");
  }

  String sentenceCase() {
    return replaceAll(RegExp(' +'), ' ')
        .split(" ")
        .map((str) => str.inCaps)
        .join(" ");
  }

  String get inCaps =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  Future<File> getFile(String extension) async {
    final Directory storage = await getApplicationDocumentsDirectory();
    return File('${storage.path}/$this.$extension');
  }
}

extension StringExtension on String {
  // String changeToLPA() {
  //   if (int.tryParse(this)! < 99) {
  //     return (int.tryParse(this)! / 1).toString();
  //   }
  //   return (int.tryParse(this)! / 100000).toString();
  // }

  bool isFutureDateTo(String pastDate) {
    try {
      if ((this).isEmpty || (pastDate).isEmpty) {
        return true;
      }

      if (DateTime.parse(this).isAfter(DateTime.parse(pastDate))) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), error: e.toString(), name: "date", level: 10);
      return true;
    }
  }

  Duration? yearDifference(String pastDate) {
    Duration? duration;
    try {
      if ((this).isEmpty || (pastDate).isEmpty) {
        return duration;
      }

      if (DateTime.parse(this).isAfter(DateTime.parse(pastDate))) {
        duration = DateTime.parse(this).difference(DateTime.parse(pastDate));
        return duration;
      }
      return duration;
    } catch (e) {
      log(e.toString(), error: e.toString(), name: "date", level: 10);
      return duration;
    }
  }

  bool isFutureYearTo(int year) {
    try {
      if ((this).isEmpty) {
        return true;
      }
      if (DateTime.parse(this).year <= year) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString(), error: e.toString(), name: "date", level: 10);
      return true;
    }
  }

  int yearCount(String? pastDate) {
    try {
      if ((this).isEmpty || (pastDate ?? '').isEmpty) {
        return 0;
      }

      DateTime futureDateTime = DateTime.parse(this);
      DateTime pastDateTime = DateTime.parse(pastDate!);
      Duration time = futureDateTime.difference(pastDateTime);

      return time.inDays ~/ 365;
    } catch (e) {
      log(e.toString(), error: e.toString(), name: "date", level: 10);
      return 0;
    }
  }

  bool isYoutubeUrl() {
    String url = toLowerCase();
    return url.contains("https:") &&
        (url.contains('shorts') || (!url.contains("channel")));
  }

  bool webUrl() {
    String url = toLowerCase();
    return url.contains("https:");
  }

  String capitalize() {
    return length < 2
        ? toUpperCase()
        : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeLine() {
    List<String> strList = split(' ');
    List<String> newStrList = List.empty(growable: true);
    for (var element in strList) {
      element.capitalize();
      newStrList.add(element);
    }
    return newStrList.join(" ");
  }
}

class CustomDateAndTime {
  static String getFormatDate(
      {required final String format, required final String date}) {
    log("print date format: $date: $format");
    if (format.isEmpty || date.isEmpty) {
      return '';
    }
    final finalFormat = format.replaceAll("kk", "hh");
    final formatDateAndTime =
        DateFormat(finalFormat).format(DateTime.parse(date).toLocal());
    return formatDateAndTime;
  }

  //DateTime.now().toUtc().toString()
  static int? yearDifference({required final String date}) {
    log("print date: $date");
    if (date.isEmpty) {
      return null;
    }
    final formatDateAndTime = DateTime.parse(date).toLocal();
    return DateTime.now().difference(formatDateAndTime).inDays ~/ 365;
  }

  static int? getAge(
      {required final String date, String dateFormat = 'yyyy-MM-dd'}) {
    log("print date: $date");
    if (date.isEmpty) {
      return null;
    }
    // print(DateTime.parse(date));
    final formatDateAndTime = DateFormat(dateFormat).parse(date).toLocal();
    return DateTime.now().difference(formatDateAndTime).inDays ~/ 365;
  }
}

extension FileExtension on File {
  getFileSize(String filepath, {int decimals = 4}) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (calc.log(bytes) / calc.log(1024)).floor(); //log1024bytes
    return '${(bytes / calc.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  num getFileSizeInMb() {
    int bytes = lengthSync();
    if (bytes <= 0) return 0;
    // var i = (calc.log(bytes) / calc.log(1024)).floor(); //log1024bytes
    return (bytes / calc.pow(1024, 2));
  }

  String getFileName() {
    String filepath = path;
    List<String> items = filepath.split('/');
    return items.isEmpty ? '' : items[items.length - 1];
  }

  File clearFile() {
    delete();
    return this;
  }
}

extension Responsive on double {
  double sp() => this;
}
