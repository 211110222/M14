import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String work;
  final String routine;
  final String other;

  const Profile({
    Key? key,
    required this.work,
    required this.routine,
    required this.other,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int workValue = int.parse(work);
    int routineValue = int.parse(routine);
    int otherValue = int.parse(other);

    int sum = workValue + routineValue + otherValue;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Stanly Winata'),
                subtitle: Text('Task finished: $sum'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Card(
                    child: Container(
                      height: 200, // Adjust the height as desired
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          const Text("Routine",style: TextStyle(fontSize: 20),),
                          Text(routine,style: TextStyle(color: Colors.red,fontSize: 70)),
                          const Text("Finished",style: TextStyle(fontSize: 20),),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Container(
                      height: 200, // Adjust the height as desired
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          const Text("Work",style: TextStyle(fontSize: 20),),
                          Text(work,style: TextStyle(color: Colors.blue,fontSize: 70),),
                          const Text("Finished",style: TextStyle(fontSize: 20),),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Container(
                      height: 200, // Adjust the height as desired
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          const Text("Other",style: TextStyle(fontSize: 20),),
                          Text(other,style: TextStyle(color: Colors.green,fontSize: 70)),
                          const Text("Finished",style: TextStyle(fontSize: 20),),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
