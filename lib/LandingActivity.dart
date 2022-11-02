import 'package:flutter/material.dart';

import 'SearchMedicine.dart';

class LandingActivity extends StatefulWidget {
  const LandingActivity({super.key, required this.title});
  final String title;

  @override
  State<LandingActivity> createState() => LandingActivityState();
}

class LandingActivityState extends State<LandingActivity> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Order Medicines',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Book lab Appointment',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.medical_information),
            icon: Icon(Icons.medical_information_outlined),
            label: 'Book Doctor Appointment',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('No Transactions'),
        ),
        Container(
         // color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Under Construction'),
        ),
        Container(
          //color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Under Construction'),
        ),
        ][currentPageIndex],
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
              margin:EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: (){
                  //action code for button 1
                },
                backgroundColor: Colors.blue,
                tooltip: 'Add Medicine',
                child: Icon(Icons.add),
              )
          ),
          Container(
              margin:EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: (){
                  //action code for button 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MaterialApp(
                      home: const SearchMedicine(title: 'Search Medicine'),
                      )),
                  );
                },
                backgroundColor: Colors.blue,
                tooltip: 'Search Medicine',
                child: Icon(Icons.search),
              )
          ),
        ],
      ),
      );
  }
}