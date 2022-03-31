import 'package:fl_band_names/models/band.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Band> bands = [
    Band(id: '1', name: 'Moby', votes: 15),
    Band(id: '2', name: 'Deftones', votes: 51),
    Band(id: '3', name: 'Korn', votes: 16),
    Band(id: '4', name: 'Metallica', votes: 23),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) { 
          return ListTile(
            leading: CircleAvatar(
              child: Text(bands[index].name.substring(0,2))
              ),
            
          );
         },
      )
    );
  }
}