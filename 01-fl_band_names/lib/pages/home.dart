import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_band_names/models/band.dart';


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
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        print('direction: $direction');
        print('id: ${band.id}');
      },
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        )
        ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text(band.name.substring(0,2)),
              backgroundColor: Colors.blue[100],
              ),
            title: Text(band.name),
            trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20),),
            onTap: (){
              print(band.name);
            },
            
          ),
    );
  }

  addNewBand(){

    final textController = TextEditingController();
    if (Platform.isAndroid){
      return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('New Band Name'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              child: const Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text)
              )
          ],
        );
      }

      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_){
        return CupertinoAlertDialog(
          title: const Text('New Band Name:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: () => addBandToList(textController.text),
              ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Close'),
              onPressed: () => Navigator.pop(context)
              ),
              
          ],
        );
      }
    );



    
  }


  void addBandToList( String name){
    
    if (name.length > 1){
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() { });
    }

    

    Navigator.pop(context);

  }


}