import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_notes_app/Boxes/boxes.dart';
import 'package:hive_notes_app/Models/notes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController=TextEditingController();
  final  descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hive Notes-APP'),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: FutureBuilder(
          //       future: Hive.openBox('safa'),
          //       builder: (context, snapshot) {
          //         return Column(
          //           children: [
          //             ListTile(
          //               title: Text(snapshot.data!.get('name').toString()),
          //               subtitle: Text(snapshot.data!.get('age').toString()),
          //               trailing: IconButton(
          //                 onPressed: () {
          //                   /*  snapshot.data?.put('name', ' safa flutter developer');
          //                   snapshot.data!.delete('age', );
          //                   setState(() {
          //
          //                   });*/
          //                 },
          //                 //  icon: Icon(Icons.edit),
          //                 icon: Icon(Icons.delete),
          //               ),
          //             ),
          //           ],
          //         );
          //       }),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
         /* var box =
              await Hive.openBox('safa'); //box or file created with name safa

          box.put('name', 'safa anwar');
          box.put('age', 30);
          box.put('details',
              {'profession': 'developer', 'degree': 'software engineering'});
          print(box.get('name'));
          print(box.get('age'));
          print(box.get('details')['profession']);
          */

        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add notes'),
            content: SingleChildScrollView(
              child: Column(
               children: [
                 TextFormField(
                   controller: titleController,
                   decoration: InputDecoration(
                     hintText: 'Enter title',
                     border: OutlineInputBorder(

                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 TextFormField(
                   controller: descriptionController,
                   decoration: InputDecoration(
                     hintText: 'Enter description',
                     border: OutlineInputBorder(

                     ),
                   ),
                 ),
               ],
              ),
            ),
            actions: [
              TextButton(onPressed: () {
                final data=NotesModel(title: titleController.text, description: descriptionController.text);
                final box=Boxes.getData();
                box.add(data);
                data.save();// extends hiveObject to save data
                print(box);
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              }, child: Text('Add')),
              TextButton(onPressed: () {

                Navigator.pop(context);
              }, child: Text('Delete')),
            ],
          );
        });
  }
}
