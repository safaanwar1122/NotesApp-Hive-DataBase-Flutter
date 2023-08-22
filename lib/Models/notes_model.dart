
import 'package:hive/hive.dart';
part 'notes_model.g.dart';
@HiveType(typeId: 0)
class NotesModel{
  @HiveField(0)
  late String title;
 @HiveField(1)
  late String description;
  NotesModel({
    required this.title, required this.description
});
}