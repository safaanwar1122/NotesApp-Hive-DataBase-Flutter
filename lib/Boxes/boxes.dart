

import 'package:hive/hive.dart';

import '../Models/notes_model.dart';

class Boxes{
  static Box<NotesModel> getData()=>Hive.box<NotesModel>('notes');

}