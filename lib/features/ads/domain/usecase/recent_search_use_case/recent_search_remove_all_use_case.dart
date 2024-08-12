import 'package:rent_hub/object_box_service.dart';

/// Removes all recent searches from the database
class RecentSearchRemoveAllUseCase {
  final db = ObjectBoxService.instance;

  void call() {
    db.searchBox.removeAll();
  }
}
