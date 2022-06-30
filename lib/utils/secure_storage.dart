import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserSecureStorage {
  final storage = FlutterSecureStorage();

  Future setStaffId(var staffId) async {
    await storage.write(key: "staffId", value: "$staffId");
  }

  Future getStaffId() async {
    var staffId = await storage.read(key: "staffId");
    return staffId;
  }

  Future setEmpName(var empName) async {
    await storage.write(key: "empName", value: "$empName");
  }

  Future getEmpName() async {
    var empName = await storage.read(key: "empName");
    return empName;
  }

  Future setBodyHeader(var bodyHeader) async {
    await storage.write(key: "bodyHeader", value: "$bodyHeader");
  }

  Future getBodyHeader() async {
    var bodyHeader = await storage.read(key: "bodyHeader");
    return bodyHeader;
  }

  Future setData(var data) async {
    await storage.write(key: "data", value: "$data");
  }

  Future getData() async {
    var data = await storage.read(key: "data");
    return data;
  }

}
