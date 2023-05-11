import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/pages/HomePage.dart';
import 'package:nutmeup/utilities/Enums.dart';

class Lastpage extends StatefulWidget {
  Lastpage({required this.status});
  STATUS status;
  @override
  State<Lastpage> createState() => _LastpageState();
}

class _LastpageState extends State<Lastpage> {
  late STATUS status;

  @override
  void initState() {
    super.initState();
    status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: status == STATUS.PENDING
            ? yellow
            : status == STATUS.SUCCESS
                ? green
                : red,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Icon(
                status == STATUS.PENDING
                    ? Icons.hourglass_empty
                    : status == STATUS.SUCCESS
                        ? Icons.check_rounded
                        : Icons.cancel,
                size: 35,
                color: status == STATUS.PENDING
                    ? yellow
                    : status == STATUS.SUCCESS
                        ? green
                        : red,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              status == STATUS.PENDING
                  ? "Operation is Pending"
                  : status == STATUS.SUCCESS
                      ? "Operation successful"
                      : "Operation Failed",
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              status == STATUS.PENDING
                  ? "Seems like there is a delay, Please\nWait while we process\nyour Operation"
                  : status == STATUS.SUCCESS
                      ? "Operation Completed Successfuly"
                      : "For some reasons, the\nOperation could not be completed",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const HomePage()),
                    (route) => false);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width / 1.2,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Text(
                  status == STATUS.PENDING
                      ? "Track progress"
                      : status == STATUS.SUCCESS
                          ? "Continue"
                          : "Try Again",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            status == STATUS.PENDING
                ? const Text(
                    "Create Invoice",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
