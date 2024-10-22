import 'package:notes/core/navigation/routes/notes_list_route.dart';

class NoteRoute {
  static const name = 'note';
  static const idKeyArg = 'id';

  static String getRouteWithArgs(String id) {
    return '${NotesListRoute.name}$name?$idKeyArg=$id';
  }
}