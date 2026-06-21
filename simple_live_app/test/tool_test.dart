import 'package:flutter_test/flutter_test.dart';
import 'package:pinyin/pinyin.dart';

void testPinyin(){
  test("测试拼音", (){
    var str = "zzz你好啊";
    var res = PinyinHelper.getShortPinyin(str);
    print(res);
  });
}

void testDirectoryCheck(String path) {
  test("测试文件夹路径检测", () {
    final regex = RegExp(r'^/([^/]+)(/[^/]+)*$');
    var res = regex.hasMatch(path);
    print(res ? "yes" : "no");
  });
}

void main(){
  var p1 = "/123/123";
  var p2 = "/123/123/123/123";
  var p3= "123";
  var p4 = "/123";
  var p5 = '/123/'; //no
  var pathList = [p1,p2,p3,p4,p5];
  for(var path in pathList){
    testDirectoryCheck(path);
  }
}