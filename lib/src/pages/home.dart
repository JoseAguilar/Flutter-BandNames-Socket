import 'dart:io';

import 'package:band_names/src/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band('1', 'Metalica', 5),
    Band('2', 'Queen', 23),
    Band('3', 'Héroes del silencio', 11),
    Band('4', 'Bon Jovi', 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => bandTile(bands[index]),
        itemCount: bands.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
   );
  }

  Widget bandTile(Band banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band', style: TextStyle(color: Colors.white))
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(banda.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(banda.name),
        trailing: Text(banda.votes.toString(), style: TextStyle(fontSize: 20),),
        onTap: (){
          print(banda.name);
        },
      ),
    );
  }

  void addNewBand(){
    final textController = new TextEditingController(); 

    if (Platform.isAndroid){
      showDialog(
        context: context, 
        builder: (_) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(controller: textController,),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
              )
            ],
          );
        },
      );
    } else{
      showCupertinoDialog(
        context: context, 
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New band name:'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dismiss'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        }
      );
    }

    
  }

  void addBandToList(String name){
    if (name.length<1)return;

    setState(() =>this.bands.add(new Band(DateTime.now().toString(), name, 0))); 

    Navigator.of(context).pop();

  }

}