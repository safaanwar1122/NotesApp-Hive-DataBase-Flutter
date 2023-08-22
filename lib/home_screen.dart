import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_notes_app/Boxes/boxes.dart';
import 'package:hive_notes_app/Models/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hive Notes-APP'),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
                itemCount: box.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(data[index].title.toString()),
                                Spacer(),
                                InkWell(
                                    onTap: () {
                                      editDialog(
                                          data[index],
                                          data[index].title.toString(),
                                          data[index].description.toString());
                                    },
                                    child: Icon(Icons.edit)),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    delete(data[index]);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              data[index].description.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
      /*Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: Hive.openBox('safa'),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(snapshot.data!.get('name').toString()),
                        subtitle: Text(snapshot.data!.get('age').toString()),
                        trailing: IconButton(
                          onPressed: () {
                            /*  snapshot.data?.put('name', ' safa flutter developer');
                            snapshot.data!.delete('age', );
                            setState(() {

                            });*/
                          },
                          //  icon: Icon(Icons.edit),
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
      */
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
          var box =
              await Hive.openBox('safa'); //box or file created with name safa

          box.put('name', 'safa anwar');
          box.put('age', 30);
          box.put('details',
              {'profession': 'developer', 'degree': 'software engineering'});
          print(box.get('name'));
          print(box.get('age'));
          print(box.get('details')['profession']);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> editDialog(
      NotesModel notesModel, String title, String description) async {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: ()async {
                    notesModel.title=titleController.text.toString();
                    await notesModel.save();
                    notesModel.description=descriptionController.text.toString();
                    descriptionController.clear();
                    titleController.clear();
                    await notesModel.save();
                    Navigator.pop(context);
                  },
                  child: Text('Edit')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    final data = NotesModel(
                        title: titleController.text,
                        description: descriptionController.text);
                    final box = Boxes.getData();
                    box.add(data);
                    //  data.save(); // extends hiveObject to save data
                    print(box);
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Add')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Delete')),
            ],
          );
        });
  }
}
