import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/emergency_sheet_content.dart';
import 'package:url_launcher/url_launcher.dart';

void showEmergencySheet(BuildContext context) {
  int counter = 5;
  Timer? timer;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          void startTimer() {
            timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
              if (counter > 0) {
                counter--;
                setState(() {});
              }

              if (counter == 0) {
                timer?.cancel();
                GoRouter.of(context).pop();
                _callTourismPolice();
              }
            });
          }

          if (timer == null) startTimer();

          return EmergencySheetContent(
            counter: counter,
            onClose: () {
              timer?.cancel();
              GoRouter.of(context).pop();
            },
            onCallNow: () {
              timer?.cancel();
              GoRouter.of(context).pop();
              _callTourismPolice();
            },
          );
        },
      );
    },
  );
}

Future<void> _callTourismPolice() async {
  final Uri url = Uri(scheme: 'tel', path: '126');
  await launchUrl(url);
}
