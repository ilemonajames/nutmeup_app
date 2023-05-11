import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutmeup/constants/Colors.dart';

late List<CameraDescription> _cameras;

class CameraContainer extends StatefulWidget {
  const CameraContainer({Key? key}) : super(key: key);

  @override
  State<CameraContainer> createState() => _CameraContainerState();
}

class _CameraContainerState extends State<CameraContainer> {
  late CameraController controller;
  bool hasCaptured = false;
  XFile? captured;
  int currentCamera = 0;
  final ImagePicker _picker = ImagePicker();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // onNewCameraSelected(cameraController.description);
    }
  }

  LoadCamera() async {
    _cameras = await availableCameras();

    controller =
        CameraController(_cameras[currentCamera], ResolutionPreset.max);
    var init = await controller.initialize();
    if (!mounted) {
      print("sss");
      return;
    }
    return "";
  }

  ActionButtons() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hasCaptured ? "Preview image" : "Tap to Snap",
            style: TextStyle(color: colorWhite, fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (hasCaptured) {
                      setState(() {
                        hasCaptured = false;
                      });
                    } else {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        captured = image;
                        hasCaptured = true;
                      });
                    }
                  },
                  child: Column(
                    children: [
                      (hasCaptured)
                          ? Icon(
                              Icons.cancel,
                              color: colorWhite,
                            )
                          : Image.asset(
                              "assets/images/icons/img_1.png",
                              width: 30,
                              height: 30,
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        hasCaptured ? "Cancel" : "Gallery",
                        style: TextStyle(color: colorWhite, fontSize: 13),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (() async {
                    if (!hasCaptured) {
                      captured = await controller.takePicture();
                      setState(() {
                        hasCaptured = true;
                      });
                    } else {}
                    // controller.buildPreview();
                  }),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(color: colorBlue, width: 4)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (hasCaptured) {
                      Navigator.pop(context, captured);
                    } else {
                      setState(() {
                        if (currentCamera == 0) {
                          currentCamera = 1;
                        } else {
                          currentCamera = 0;
                        }
                      });
                    }
                  },
                  child: Column(
                    children: [
                      hasCaptured
                          ? Icon(
                              Icons.check,
                              color: colorWhite,
                            )
                          : (currentCamera == 0)
                              ? Image.asset(
                                  "assets/images/icons/img_2.png",
                                  width: 30,
                                  height: 30,
                                )
                              : Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      color: colorLightBlue,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Image.asset(
                                    "assets/images/icons/img_2.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        hasCaptured ? "Done" : "Switch",
                        style: TextStyle(color: colorWhite, fontSize: 13),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // LoadCamera();
    // controller = CameraController(_cameras[0], ResolutionPreset.max);
    // controller.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // }).catchError((Object e) {
    //   if (e is CameraException) {
    //     switch (e.code) {
    //       case 'CameraAccessDenied':
    //         print('User denied camera access.');
    //         break;
    //       default:
    //         print('Handle other errors.');
    //         break;
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: LoadCamera(),
      builder: (a, b) {
        if (b.hasData) {
          return !controller.value.isInitialized
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: const Text("Could not load camera"),
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: CameraPreview(
                            controller,
                          ),
                        )
                      ],
                    ),
                    hasCaptured
                        ? (captured != null)
                            ? Image.file(
                                File.fromUri(Uri.parse(captured!.path)),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    Positioned(
                        child: Container(
                      margin: const EdgeInsets.only(
                          top: 50, left: 20, right: 20, bottom: 20),
                      child: Row(children: [
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            color: colorWhite,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(color: colorWhite),
                        )
                      ]),
                    )),
                    Positioned(bottom: 30, child: ActionButtons())
                  ],
                );
        } else {
          return Container(
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    ));
  }
}
