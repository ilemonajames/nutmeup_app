import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';

showMessageDialog(context, {required String title , required String message , onProceed , onCancel}) async {


  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:  const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(10),
                  decoration:  const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                           BorderRadius.all(Radius.circular(10))),
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade600)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: onProceed ?? () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: colorBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Text(
                                "   Yes   ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: onCancel ??  () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: blue.withOpacity(.1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: const Text(
                                "   Cancel   ",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 14),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                )
              ]),
        );
      });
}
