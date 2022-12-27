import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'HomeController.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  bool autoValidate = false;
  bool loading = false;
  // ignore: non_constant_identifier_names
  final Ref = FirebaseDatabase.instance.ref('post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.itemCount.value,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange,
                            ),
                            child: Center(
                              child: ListTile(
                                title: Text('$index'),
                                subtitle:
                                    Text(controller.names.value[index].name),
                                    
                                trailing: GestureDetector(
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    // Ref.child(DateTime.now()
                                    //         .millisecondsSinceEpoch
                                    //         .toString())
                                    //     .remove();
                                    controller.removeName(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    )),
              ),
              DraggableScrollableSheet(
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(0)),
                      color: Colors.black,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // ignore: prefer_const_constructors
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10)),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    controller:
                                        controller.nameTextEditingController,
                                    decoration: InputDecoration(
                                      labelText: 'Add Player Name',
                                      // errorText: _errorText,
                                    ),
                                  ),
                                ),
                              ),

                              IconButton(
                                icon: const Icon(Icons.add_circle),
                                color: Colors.white,
                                iconSize: 30,
                                onPressed: () {
                                  if (controller.nameTextEditingController.value
                                      .text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                "please enter some valueS"),
                                          );
                                        });
                                  } else {
                                    Ref.child(DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString())
                                        .set({
                                      'tittle': controller
                                          .nameTextEditingController.value.text
                                          .toString()
                                    }).then((value) {
                                      controller.addName(controller
                                          .nameTextEditingController.text);
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        MaterialButton(
                          minWidth: 150,
                          height: 35,
                          onPressed: () {
                            try {
                              if (controller.itemCount.value < 2) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "check minimum 2 player added before game start"),
                                      );
                                    });
                              } else {
                                Get.to(MyHome());
                              }
                            } on Exception catch (_) {
                              Text('never reached');
                            }
                          },
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "LET'S PLAY",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                initialChildSize: 0.25,
                minChildSize: 0.25,
                maxChildSize: 0.50,
              ),
            ],
          )),
    );
  }

//   String? get _errorText {
//     // at any time, we can get the text from _controller.value.text
//     final text = controller.nameTextEditingController.value.text;
//     // Note: you can do your own custom validation here
//     // Move this logic this outside the widget for more testable code
//     if (text.isEmpty) {
//       return 'Abe Saale';
//     }

//     // return null if the text is valid
//     return null;
//   }
}
