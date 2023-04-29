import 'package:finding_falcone_app/Helpers/UIHelpers.dart';
import 'package:finding_falcone_app/Models/FindRequest.dart';
import 'package:finding_falcone_app/Models/PlanetName.dart';
import 'package:finding_falcone_app/Success.dart';
import 'Models/TimeTaken.dart';
import 'Models/Vehicles.dart';
import 'package:flutter/material.dart';
import 'Models/Planets.dart';
import 'ServicesManager/AppUrls.dart';
import 'ServicesManager/ServerExplorer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Finding Falcone!",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Finding Falcone!"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Planets> planetsList = [];
  List<Vehicles> spaceVehiclesList = [];
  List<TimeTaken> timeTakenList = [];
  Planets? selPlanet1, selPlanet2, selPlanet3, selPlanet4;
  Vehicles? selVehicle1, selVehicle2, selVehicle3, selVehicle4;
  String errorMsg = "Something went wrong. Please try again";
  var list1 = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getPlanetsApiCall();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Finding Falcone!"),
        ),
        body: GestureDetector(
            onTap: () {
              /*This method here will hide the soft keyboard.*/
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Invoke "debug painting" (press "p" in the console, choose the
                  // "Toggle Debug Paint" action from the Flutter Inspector in Android
                  // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                  // to see the wireframe for each widget.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          style: const ButtonStyle(
                              alignment: AlignmentDirectional.topEnd),
                          child: const Text("Reset"),
                          onPressed: () async {
                            resetFinding();
                          },
                        )),
                    Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Select planets you want to search in:',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    UIHelpers.instance.sizedBoxGenerator(15),
                    Container(
                        alignment: Alignment.center,
                        child: Text('Time taken: ${calculateTimeTaken()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Destination 1'),
                        UIHelpers.instance.sizedBoxGenerator(10),
                        Row(
                          children: [
                            SizedBox(
                              //child:(
                              width: 100,
                              height: 50,
                              child: DropdownButtonFormField<Planets>(
                                  isExpanded: true,
                                  icon: Image.asset(
                                    "images/Icon - Arrow Down.png",
                                    height: 20,
                                  ),
                                  decoration: inputdecorationGenerator(""),
                                  iconEnabledColor: Colors.grey,
                                  items: planetsList.map((value) {
                                    return DropdownMenuItem<Planets>(
                                      value: value,
                                      child: Text(
                                        value.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: const Text(
                                    "Select",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  onChanged: (Planets? value) {
                                    setState(() {
                                      selPlanet1 = value;
                                      //if (timeTakenList.length == 1) {
                                      timeTakenList = [];
                                      selVehicle1 = null;
                                      //}
                                      TimeTaken timeTakenValue = TimeTaken();
                                      timeTakenValue.planetName = value?.name;
                                      timeTakenValue.distance = value?.distance;
                                      timeTakenValue.index = 0;
                                      timeTakenList.add(timeTakenValue);
                                      selPlanet2 = null;
                                      selVehicle2 = null;
                                      selPlanet3 = null;
                                      selVehicle3 = null;
                                      selPlanet4 = null;
                                      selVehicle4 = null;
                                    });
                                  },
                                  value: (selPlanet1 != null)
                                      ? (planetsList
                                          .where((element) =>
                                              element.name == selPlanet1?.name)
                                          .toList()
                                          .first)
                                      : null),
                            ),
                          ],
                        ),
                        selPlanet1 != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UIHelpers.instance.sizedBoxGenerator(10),
                                  const Text('Vehicle 1'),
                                  ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: spaceVehiclesList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          title: Text(
                                            '${spaceVehiclesList[index].name} (${(selVehicle1 != null && (selVehicle1?.name == spaceVehiclesList[index].name)) ? list1[index] - 1 : list1[index]})',
                                          ),
                                          leading: Radio(
                                            fillColor: MaterialStateColor.resolveWith(
                                                (states) => (timeTakenList
                                                            .isNotEmpty &&
                                                        (timeTakenList.first
                                                                    .distance !=
                                                                null &&
                                                            timeTakenList.first
                                                                    .distance! >
                                                                spaceVehiclesList[
                                                                        index]
                                                                    .maxDistance))
                                                    ? Colors.grey
                                                    : Colors.black),
                                            //  activeColor: Colors.blue,
                                            value: spaceVehiclesList[index],
                                            groupValue: selVehicle1,
                                            onChanged: (timeTakenList
                                                        .isNotEmpty &&
                                                    (timeTakenList.first
                                                                .distance !=
                                                            null &&
                                                        timeTakenList.first
                                                                .distance! >
                                                            spaceVehiclesList[
                                                                    index]
                                                                .maxDistance))
                                                ? null
                                                : (Vehicles? value) {
                                                    setState(() {
                                                      selVehicle1 = value;
                                                      if (timeTakenList
                                                          .isNotEmpty) {
                                                        timeTakenList[0].speed =
                                                            value?.speed;
                                                        timeTakenList[0]
                                                                .vehicleName =
                                                            value?.name;
                                                        timeTakenList[0]
                                                                .vehicleMaxDistance =
                                                            value?.maxDistance;
                                                        timeTakenList[0]
                                                                .totalNo =
                                                            value?.totalNo;
                                                      }
                                                    });
                                                    selPlanet2 = null;
                                                    selVehicle2 = null;
                                                    selPlanet3 = null;
                                                    selVehicle3 = null;
                                                    selPlanet4 = null;
                                                    selVehicle4 = null;
                                                    if (timeTakenList.length >
                                                        1) {
                                                      timeTakenList.removeRange(
                                                          1,
                                                          timeTakenList.length);
                                                    }
                                                  },
                                          ),
                                        );
                                      }),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    UIHelpers.instance.sizedBoxGenerator(10),
                    const Text('Destination 2'),
                    UIHelpers.instance.sizedBoxGenerator(10),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: DropdownButtonFormField<Planets>(
                              isExpanded: true,
                              icon: Image.asset(
                                "images/Icon - Arrow Down.png",
                                height: 20,
                              ),
                              decoration: inputdecorationGenerator(""),
                              iconEnabledColor: Colors.grey,
                              items: getPlanetsList(1).map((value) {
                                return DropdownMenuItem<Planets>(
                                  value: value,
                                  child: Text(
                                    value.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              hint: const Text(
                                "Select",
                                style: TextStyle(fontSize: 14),
                              ),
                              validator: (value) =>
                                  (selPlanet1 != null && selVehicle1 != null)
                                      ? ""
                                      : 'Please select vehicle 1 option',
                              onTap: () {
                                setState(() {
                                  if (selPlanet1 != null &&
                                      selVehicle1 != null) {}
                                  //  else {
                                  //   checkValidation();
                                  // }
                                });
                              },
                              onChanged: (Planets? value) {
                                setState(() {
                                  if (selPlanet1 != null &&
                                      selVehicle1 != null) {
                                    selPlanet2 = value;
                                    if (timeTakenList.length == 2) {
                                      timeTakenList.removeAt(1);
                                      selVehicle2 = null;
                                    }
                                    TimeTaken timeTakenValue = TimeTaken();
                                    timeTakenValue.planetName = value?.name;
                                    timeTakenValue.distance = value?.distance;
                                    timeTakenValue.index = 1;
                                    timeTakenList.add(timeTakenValue);

                                    selPlanet3 = null;
                                    selVehicle3 = null;
                                    selPlanet4 = null;
                                    selVehicle4 = null;
                                  }
                                  //  else {
                                  //   checkValidation();
                                  // }
                                });
                              },
                              value: (selPlanet2 != null)
                                  ? (getPlanetsList(1)
                                      .where((element) =>
                                          element.name == selPlanet2?.name)
                                      .toList()
                                      .first)
                                  : null),
                        ),
                      ],
                    ),
                    showVehiclesRadioList(1, selPlanet2, selVehicle2),
                    UIHelpers.instance.sizedBoxGenerator(10),
                    const Text('Destination 3'),
                    UIHelpers.instance.sizedBoxGenerator(10),
                    Row(
                      children: [
                        SizedBox(
                          //child:(
                          width: 100,
                          height: 50,
                          child: DropdownButtonFormField<Planets>(
                              isExpanded: true,
                              icon: Image.asset(
                                "images/Icon - Arrow Down.png",
                                height: 20,
                              ),
                              decoration: inputdecorationGenerator(""),
                              iconEnabledColor: Colors.grey,
                              items: getPlanetsList(2).map((value) {
                                return DropdownMenuItem<Planets>(
                                  value: value,
                                  child: Text(
                                    value.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              hint: const Text(
                                "Select",
                                style: TextStyle(fontSize: 14),
                              ),
                              onTap: () {
                                setState(() {
                                  if (selPlanet1 != null &&
                                      selVehicle1 != null &&
                                      selPlanet2 != null &&
                                      selVehicle2 != null) {}
                                  //  else {
                                  //   checkValidation();
                                  // }
                                });
                              },
                              onChanged: (Planets? value) {
                                setState(() {
                                  if (selPlanet1 != null &&
                                      selVehicle1 != null &&
                                      selPlanet2 != null &&
                                      selVehicle2 != null) {
                                    selPlanet3 = value;
                                    if (timeTakenList.length == 3) {
                                      timeTakenList.removeAt(2);
                                      selVehicle3 = null;
                                    }
                                    TimeTaken timeTakenValue = TimeTaken();
                                    timeTakenValue.planetName = value?.name;
                                    timeTakenValue.distance = value?.distance;
                                    timeTakenValue.index = 2;
                                    timeTakenList.add(timeTakenValue);
                                    selPlanet4 = null;
                                    selVehicle4 = null;
                                  }
                                  //  else {
                                  //   checkValidation();
                                  // }
                                });
                              },
                              value: (selPlanet3 != null)
                                  ? (getPlanetsList(2)
                                      .where((element) =>
                                          element.name == selPlanet3?.name)
                                      .toList()
                                      .first)
                                  : null),
                        ),
                      ],
                    ),
                    showVehiclesRadioList(2, selPlanet3, selVehicle3),
                    UIHelpers.instance.sizedBoxGenerator(10),
                    const Text('Destination 4'),
                    UIHelpers.instance.sizedBoxGenerator(10),
                    Row(
                      children: [
                        SizedBox(
                          //child:(
                          width: 100,
                          height: 50,
                          child: DropdownButtonFormField<Planets>(
                              isExpanded: true,
                              icon: Image.asset(
                                "images/Icon - Arrow Down.png",
                                height: 20,
                              ),
                              decoration: inputdecorationGenerator(""),
                              iconEnabledColor: Colors.grey,
                              items: getPlanetsList(3).map((value) {
                                return DropdownMenuItem<Planets>(
                                  value: value,
                                  child: Text(
                                    value.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              hint: const Text(
                                "Select",
                                style: TextStyle(fontSize: 14),
                              ),
                              onTap: () {
                                setState(() {
                                  if (selPlanet1 != null &&
                                      selVehicle1 != null &&
                                      selPlanet2 != null &&
                                      selVehicle2 != null &&
                                      selPlanet3 != null &&
                                      selVehicle3 != null) {}
                                  //  else {
                                  //   checkValidation();
                                  // }
                                });
                              },
                              onChanged: (Planets? value) {
                                setState(() {
                                  if (selPlanet1 != null &&
                                      selVehicle1 != null &&
                                      selPlanet2 != null &&
                                      selVehicle2 != null &&
                                      selPlanet3 != null &&
                                      selVehicle3 != null) {
                                    selPlanet4 = value;
                                    if (timeTakenList.length == 4) {
                                      timeTakenList.removeAt(3);
                                      selVehicle4 = null;
                                    }
                                    TimeTaken timeTakenValue = TimeTaken();
                                    timeTakenValue.planetName = value?.name;
                                    timeTakenValue.distance = value?.distance;
                                    timeTakenValue.index = 3;
                                    timeTakenList.add(timeTakenValue);
                                  }
                                  //  else {
                                  //   checkValidation();
                                  // }
                                });
                              },
                              value: (selPlanet4 != null)
                                  ? (getPlanetsList(3)
                                      .where((element) =>
                                          element.name == selPlanet4?.name)
                                      .toList()
                                      .first)
                                  : null),
                        ),
                      ],
                    ),
                    showVehiclesRadioList(3, selPlanet4, selVehicle4),
                    UIHelpers.instance.sizedBoxGenerator(30),
                    Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width * 0.7, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                  (selPlanet1 != null &&
                                          selVehicle1 != null &&
                                          selPlanet2 != null &&
                                          selVehicle2 != null &&
                                          selPlanet3 != null &&
                                          selVehicle3 != null &&
                                          selPlanet4 != null &&
                                          selVehicle4 != null)
                                      ? Colors.blue
                                      : Colors.grey),
                              alignment: Alignment.center),
                          onPressed: () {
                            if (selPlanet1 != null &&
                                selVehicle1 != null &&
                                selPlanet2 != null &&
                                selVehicle2 != null &&
                                selPlanet3 != null &&
                                selVehicle3 != null &&
                                selPlanet4 != null &&
                                selVehicle4 != null) {
                              postFindTokenApiCall();
                            }
                          },
                          child: const Text(
                            'Find Falcone!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            )));
  }

  InputDecoration inputdecorationGenerator(String placeholder) {
    return InputDecoration(
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      hintText: placeholder,
    );
  }

//call planets api
  getPlanetsApiCall() async {
    try {
      var result = await ServerExplorer.httpGet(
          requestUrl: AppsUrls.planets, context: context);
      if ((result.isSuccess ?? false) && (result.data != null)) {
        planetsList =
            (result.data as List).map((d) => Planets.fromJson(d)).toList();
        getVehiclesApiCall();
      } else {}

      //setState(() {});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

//call vehicles api
  getVehiclesApiCall() async {
    try {
      var result = await ServerExplorer.httpGet(
          requestUrl: AppsUrls.vehicles, context: context);
      if ((result.isSuccess ?? false) && (result.data != null)) {
        spaceVehiclesList =
            (result.data as List).map((d) => Vehicles.fromJson(d)).toList();
        for (int i = 0; i < spaceVehiclesList.length; i++) {
          list1.add(spaceVehiclesList[i].totalNo);
        }
      } else {}

      setState(() {});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

//method to get timetaken
  int calculateTimeTaken() {
    //t=d/s
    int timeTaken = 0;
    if (timeTakenList.isNotEmpty) {
      for (var element in timeTakenList) {
        if (element.distance != null && element.speed != null) {
          timeTaken += (element.distance ?? 0) ~/ (element.speed ?? 0);
        }
      }
    }
    return timeTaken;
  }

//show planets list as dropdown for each selection with updating the planets with filtering of selected planets to not show in later selection
  List<Planets> getPlanetsList(int index) {
    List<Planets> filterPlanetsList = [];
    if (timeTakenList.isNotEmpty) {
      if (index == 1) {
        if (selPlanet1 != null && selVehicle1 != null) {
          for (var planet in planetsList) {
            if (timeTakenList
                .where((element) =>
                    ((element.index != null && element.index! > 0) &&
                        element.planetName == planet.name))
                .isNotEmpty) {
              filterPlanetsList.add(planet);
            } else if (timeTakenList
                .where((element) => element.planetName == planet.name)
                .isEmpty) {
              filterPlanetsList.add(planet);
            }
          }
        }
      } else if (index == 2) {
        if (selPlanet1 != null &&
            selVehicle1 != null &&
            selPlanet2 != null &&
            selVehicle2 != null) {
          for (var planet in planetsList) {
            if (timeTakenList
                .where((element) =>
                    ((element.index != null && element.index! > 1) &&
                        element.planetName == planet.name))
                .isNotEmpty) {
              filterPlanetsList.add(planet);
            } else if (timeTakenList
                .where((element) => element.planetName == planet.name)
                .isEmpty) {
              filterPlanetsList.add(planet);
            }
          }
        }
      } else if (index == 3) {
        if (selPlanet1 != null &&
            selVehicle1 != null &&
            selPlanet2 != null &&
            selVehicle2 != null &&
            selPlanet3 != null &&
            selVehicle3 != null) {
          for (var planet in planetsList) {
            if (timeTakenList
                .where((element) =>
                    ((element.index != null && element.index! > 2) &&
                        element.planetName == planet.name))
                .isNotEmpty) {
              filterPlanetsList.add(planet);
            } else if (timeTakenList
                .where((element) => element.planetName == planet.name)
                .isEmpty) {
              filterPlanetsList.add(planet);
            }
          }
        }
      }
    }
    return filterPlanetsList;
  }

//show vehicles list as radio buttons for each selection with updating the available count of vehicles
  List<Vehicles> getVehiclesList(int index) {
    List<Vehicles> vehicleList1 = spaceVehiclesList;
    var list2 = [];
    list2 = List.of(list1);
    List<Vehicles> filterVehiclesList = List.of(vehicleList1);
    if (timeTakenList.isNotEmpty) {
      if (index == 0) {
      } else if (index == 1) {
        if (timeTakenList.length == 2) {
          for (int i = 0; i < filterVehiclesList.length; i++) {
            if (timeTakenList.first.vehicleName == filterVehiclesList[i].name) {
              list2[i] = list1[i] - 1;
              filterVehiclesList[i].totalNo = list2[i];
            }
          }
        }
      } else if (index == 2) {
        if (timeTakenList.length == 3) {
          for (int i = 0; i < spaceVehiclesList.length; i++) {
            if (timeTakenList.first.vehicleName == spaceVehiclesList[i].name) {
              list2[i] = list1[i] - 1;
              filterVehiclesList[i].totalNo = list2[i];
            }
            if (timeTakenList[1].vehicleName == spaceVehiclesList[i].name) {
              list2[i] = list1[i] - 1;
              filterVehiclesList[i].totalNo = list2[i];
            }
          }
        }
      } else if (index == 3) {
        if (timeTakenList.length == 4) {
          for (int i = 0; i < spaceVehiclesList.length; i++) {
            if (timeTakenList.first.vehicleName == spaceVehiclesList[i].name) {
              list2[i] = list1[i] - 1;
              filterVehiclesList[i].totalNo = list2[i];
            }
            if (timeTakenList[1].vehicleName == spaceVehiclesList[i].name) {
              list2[i] = list1[i] - 1;
              filterVehiclesList[i].totalNo = list2[i];
            }
            if (timeTakenList[2].vehicleName == spaceVehiclesList[i].name) {
              list2[i] = list1[i] - 1;
              filterVehiclesList[i].totalNo = list2[i];
            }
          }
        }
      }
    }
    return filterVehiclesList;
  }

//reusable method to show ui of vehicles list and count
  Widget showVehiclesRadioList(int vehicleIndex, Planets? selectPlanetValue,
      Vehicles? selectVehicleValue) {
    var vehicleList = getVehiclesList(vehicleIndex);
    return selectPlanetValue != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                UIHelpers.instance.sizedBoxGenerator(10),
                Text('Vehicle ${vehicleIndex + 1}'),
                ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: vehicleList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          '${vehicleList[index].name} (${list1[index] - getSelectedVehiclesTotalNum(vehicleList[index], vehicleIndex)})', //(${(selectVehicleValue != null && (selectVehicleValue?.name == vehicleList[index].name)) ? list1[index] - 1 : list1[index]})',
                        ),
                        leading: Radio(
                          fillColor: MaterialStateColor.resolveWith((states) =>
                              (timeTakenList.isNotEmpty &&
                                      ((timeTakenList[vehicleIndex].distance !=
                                                  null &&
                                              timeTakenList[vehicleIndex]
                                                      .distance! >
                                                  vehicleList[index]
                                                      .maxDistance) ||
                                          ((list1[index] -
                                                  getSelectedVehiclesTotalNum(
                                                      vehicleList[index],
                                                      vehicleIndex)) ==
                                              0)))
                                  ? Colors.grey
                                  : Colors.black),
                          //  activeColor: Colors.blue,
                          value: vehicleList[index],
                          groupValue: selectVehicleValue,
                          onChanged: (timeTakenList.isNotEmpty &&
                                  ((timeTakenList[vehicleIndex].distance !=
                                              null &&
                                          timeTakenList[vehicleIndex]
                                                  .distance! >
                                              vehicleList[index].maxDistance) ||
                                      ((list1[index] -
                                              getSelectedVehiclesTotalNum(
                                                  vehicleList[index],
                                                  vehicleIndex)) ==
                                          0)))
                              ? null // this disable should happen based on distance and availabilty of vehicles too- this need to be checked
                              : (Vehicles? value) {
                                  setState(() {
                                    if (vehicleIndex == 1) {
                                      selVehicle2 = value;
                                      selPlanet3 = null;
                                      selVehicle3 = null;
                                      selPlanet4 = null;
                                      selVehicle4 = null;
                                      if (timeTakenList.length >
                                          vehicleIndex + 1) {
                                        timeTakenList.removeRange(
                                            vehicleIndex + 1,
                                            timeTakenList.length);
                                      }
                                    } else if (vehicleIndex == 2) {
                                      selVehicle3 = value;
                                      selPlanet4 = null;
                                      selVehicle4 = null;
                                      if (timeTakenList.length >
                                          vehicleIndex + 1) {
                                        timeTakenList.removeRange(
                                            vehicleIndex + 1,
                                            timeTakenList.length);
                                      }
                                    } else if (vehicleIndex == 3) {
                                      selVehicle4 = value;
                                    }
                                    selectVehicleValue = value;
                                    if (timeTakenList.isNotEmpty) {
                                      timeTakenList[vehicleIndex].speed =
                                          value?.speed;
                                      timeTakenList[vehicleIndex].vehicleName =
                                          value?.name;
                                      timeTakenList[vehicleIndex]
                                              .vehicleMaxDistance =
                                          value?.maxDistance;
                                      timeTakenList[vehicleIndex].totalNo =
                                          value?.totalNo;
                                    }
                                  });
                                },
                        ),
                      );
                    })
              ])
        : Container();
  }

//method to get total number of selected vehicle on each selection
  getSelectedVehiclesTotalNum(Vehicles value, int index) {
    if (index == 1) {
      if (selVehicle1 != null) {
        if (timeTakenList.length >= 2) {
          var timeTakenList2 = [];
          for (var element in timeTakenList) {
            if (timeTakenList2.length < 2) {
              timeTakenList2.add(element);
            }
          }
          var filterVehicles = timeTakenList2
              .where((element) => element.vehicleName == value.name);
          if (filterVehicles.isNotEmpty) {
            if (filterVehicles.length == 1) {
              return 1;
            } else if (filterVehicles.length == 2) {
              return 2;
            }
          }
        }
      }
    } else if (index == 2) {
      if (selVehicle2 != null) {
        if (timeTakenList.length >= 3) {
          var timeTakenList3 = [];
          for (var element in timeTakenList) {
            if (timeTakenList3.length < 3) {
              timeTakenList3.add(element);
            }
          }
          var filterVehicles = timeTakenList3
              .where((element) => element.vehicleName == value.name);
          if (filterVehicles.isNotEmpty) {
            if (filterVehicles.length == 1) {
              return 1;
            } else if (filterVehicles.length == 2) {
              return 2;
            }
          }
        }
      }
    } else if (index == 3) {
      if (selVehicle3 != null) {
        if (timeTakenList.length == 4) {
          var timeTakenList4 = [];
          for (var element in timeTakenList) {
            if (timeTakenList4.length < 4) {
              timeTakenList4.add(element);
            }
          }
          var filterVehicles = timeTakenList4
              .where((element) => element.vehicleName == value.name);
          if (filterVehicles.isNotEmpty) {
            if (filterVehicles.length == 1) {
              return 1;
            } else if (filterVehicles.length == 2) {
              return 2;
            }
          }
        }
      }
    }
    return 0;
  }

//call token api
  postFindTokenApiCall() async {
    try {
      var result = await ServerExplorer.httpPost(
          requestUrl: AppsUrls.token, context: context);
      if ((result.isSuccess ?? false) && (result.data != null)) {
        if (result.data['token'] != null && result.data['token'].isNotEmpty) {
          postFindFalconeApiCall(result.data['token']);
        } else {
          UIHelpers.instance.showToast(errorMsg);
        }
      } else {
        UIHelpers.instance.showToast(errorMsg);
      }

      setState(() {});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

//call find api to get planet name
  postFindFalconeApiCall(String token) async {
    try {
      List<String> planetNames = [];
      List<String> vehicleNames = [];

      if (timeTakenList.isNotEmpty) {
        for (var element in timeTakenList) {
          planetNames.add(element.planetName ?? "");
          vehicleNames.add(element.vehicleName ?? "");
        }
      }
      FindRequest findRequest = FindRequest(
          token: token, planetNames: planetNames, vehicleNames: vehicleNames);
      var result = await ServerExplorer.httpPost(
          requestModel: findRequest,
          requestUrl: AppsUrls.find,
          context: context);
      if ((result.isSuccess ?? false) && (result.data != null)) {
        if (result.data != null) {
          // if (result.data['status']) {

          // }
          var response = PlanetName.fromJson(result.data);
          if (response.status?.toLowerCase() == "success") {
            //Navigate to success screen with planet name and time taken
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Success(
                  planetName: response.planetName,
                  timeTaken: calculateTimeTaken(),
                ),
              ),
            ).then((value) => {resetFinding()});
          } else {
            //
            UIHelpers.instance.showToast(errorMsg);
          }
        }
      } else {
        UIHelpers.instance.showToast(errorMsg);
      }

      setState(() {});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

//method to reset or restart the game
  resetFinding() {
    timeTakenList = [];
    selPlanet1 = null;
    selPlanet2 = null;
    selPlanet3 = null;
    selPlanet4 = null;
    selVehicle1 = null;
    selVehicle2 = null;
    selVehicle3 = null;
    selVehicle4 = null;
    setState(() {});
  }

//validation for checking planets and vehicles are selected or not in order
  checkValidation() {
    if (selPlanet1 == null || selVehicle1 == null) {
//UIHelpers.instance.showToast('Please select destination 1 details');
      checkBasicValidation(1, selPlanet1, selVehicle1);
    } else if (selPlanet2 == null || selVehicle2 == null) {
      checkBasicValidation(2, selPlanet2, selVehicle2);
    } else if (selPlanet3 == null || selVehicle3 == null) {
      checkBasicValidation(3, selPlanet3, selVehicle3);
    } else if (selPlanet4 == null || selVehicle4 == null) {
      checkBasicValidation(4, selPlanet4, selVehicle4);
    }
    return;
  }

//validation for showing toast with which planet or vehicle to select
  checkBasicValidation(int index, selPlanetValue, selVehicleValue) {
    if (selVehicleValue == null) {
      UIHelpers.instance.showToast('Please select vehicle $index option');
    } else {
      UIHelpers.instance.showToast('Please select destination $index option');
    }
  }

  //to check planets and vehicles data easily
//dropdown validation should be checked properly
// space_pod- 2
// max dis- 200

// space rocket-1
// 300

// space shuttle-1
// 400
// space ship-2
// 600

// donlon-100

// enchain-200

// jibing-300

// sapir-400

// lerbin-500

// pingasor-600
}