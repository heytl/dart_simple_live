import 'dart:convert';

import 'package:simple_live_app/models/version_model.dart';
import 'package:simple_live_app/requests/http_client.dart';

/// 通用的请求
class CommonRequest {
  Future<VersionModel> checkUpdate() async {
    try {
      return await checkUpdateGitMirror();
    } catch (e) {
      return await checkUpdateJsDelivr();
    }
  }

  /// 检查更新
  Future<VersionModel> checkUpdateGitMirror() async {
    var result = await HttpClient.instance.getJson(
      "https://raw.gitmirror.com/slotsun/dart_simple_live/master/assets/app_version.json",
      queryParameters: {
        "ts": DateTime.now().millisecondsSinceEpoch,
      },
    );
    if (result is Map) {
      return VersionModel.fromJson(result as Map<String, dynamic>);
    }
    return VersionModel.fromJson(json.decode(result));
  }

  /// 检查更新
  Future<VersionModel> checkUpdateJsDelivr() async {
    var result = await HttpClient.instance.getJson(
      "https://cdn.jsdelivr.net/gh/slotsun/dart_simple_live@master/assets/app_version.json",
      queryParameters: {
        "ts": DateTime.now().millisecondsSinceEpoch,
      },
    );
    if (result is Map) {
      return VersionModel.fromJson(result as Map<String, dynamic>);
    }
    return VersionModel.fromJson(json.decode(result));
  }

  /// 拉取虎牙配置
  Future<Map<String, dynamic>> fetchHuyaConfig() async {
    try {
      return await _fetchHuyaConfigGitMirror();
    } catch (e) {
      return await _fetchHuyaConfigJsDelivr();
    }
  }

  Future<Map<String, dynamic>> _fetchHuyaConfigGitMirror() async {
    var result = await HttpClient.instance.getJson(
      "https://raw.gitmirror.com/slotsun/dart_simple_live/master/assets/huya_config.json",
      queryParameters: {
        "ts": DateTime.now().millisecondsSinceEpoch,
      },
    );
    if (result is Map) {
      return result as Map<String, dynamic>;
    }
    return json.decode(result) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _fetchHuyaConfigJsDelivr() async {
    var result = await HttpClient.instance.getJson(
      "https://cdn.jsdelivr.net/gh/slotsun/dart_simple_live@master/assets/huya_config.json",
      queryParameters: {
        "ts": DateTime.now().millisecondsSinceEpoch,
      },
    );
    if (result is Map) {
      return result as Map<String, dynamic>;
    }
    return json.decode(result) as Map<String, dynamic>;
  }
}
