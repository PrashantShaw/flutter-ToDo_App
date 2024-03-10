import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 0; // Unique identifier for this adapter

  @override
  TodoModel read(BinaryReader reader) {
    return TodoModel(
      // Deserialize TodoModel object from binary data
      id: reader.readString(),
      task: reader.readString(),
      isComplete: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    // Serialize TodoModel object to binary data
    writer.writeString(obj.id);
    writer.writeString(obj.task);
    writer.writeBool(obj.isComplete);
  }
}
