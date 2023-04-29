import 'package:flutter/material.dart';
import 'Helpers/UIHelpers.dart';

//Success screen for showing planet found and time taken
class Success extends StatefulWidget {
  // Success({Key? key}) : super(key: key);
  String? planetName;
  int? timeTaken;
  Success({this.planetName, this.timeTaken});
  @override
  State<Success> createState() =>
      _SuccessState(planetName: planetName, timeTaken: timeTaken);
}

class _SuccessState extends State<Success> {
  String? planetName;
  int? timeTaken;
  _SuccessState({this.planetName, this.timeTaken});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: const Text("Finding Falcone Success!"),
            ),
            body: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Success! Congratulations on Finding Falcone. King Shan is mighty pleased.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    UIHelpers.instance.sizedBoxGenerator(15),
                    Text(
                      "Time taken: $timeTaken",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    UIHelpers.instance.sizedBoxGenerator(15),
                    Text(
                      "Planet found: $planetName",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    UIHelpers.instance.sizedBoxGenerator(50),
                    ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width * 0.7, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          alignment: Alignment.center),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Start Again',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}