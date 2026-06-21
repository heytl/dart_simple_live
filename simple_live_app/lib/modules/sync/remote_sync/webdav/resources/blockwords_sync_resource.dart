import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:simple_live_app/modules/sync/remote_sync/webdav/interface/sync_resource.dart';
import 'package:simple_live_app/services/local_storage_service.dart';

class BlockwordsSyncResource implements SyncResource<List<String>> {
  @override
  String get fileName => "SimpleLive_blocked_word.json";

  @override
  Future<List<String>> loadLocal() async {
    return LocalStorageService.instance.shieldBox.values.toList();
  }

  @override
  List<String>? loadRemote(Archive archive) {
    final file = archive.findFile(fileName);
    if (file == null) return null;
    final jsonData = jsonDecode(utf8.decode(file.content));
    return (jsonData['data'] as List).cast<String>();
  }

  @override
  Future<void> saveLocal(List<String> data) async {
    await LocalStorageService.instance.shieldBox.clear();
    await LocalStorageService.instance.shieldBox.addAll(data);
  }

  @override
  void saveRemote(Archive archive, List<String> data) {
    final bytes = utf8.encode(jsonEncode({
      'data': data,
    }));
    archive.addFile(
      ArchiveFile(fileName, bytes.length, bytes),
    );
  }

  @override
  List<String> merge(List<String> local, List<String> remote) {
    return {...local, ...remote}.toList();
  }
}
