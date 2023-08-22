import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hive Notes-APP'),
      ),
      body: Column(
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
                          //  snapshot.data?.put('name', ' safa flutter developer');
                            snapshot.data!.delete('age', );
                            setState(() {
                              
                            });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
}
