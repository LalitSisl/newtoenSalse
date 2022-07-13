import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserSecureStorage {
  final storage = FlutterSecureStorage();

  Future setStaffId(var staffId) async {
    await storage.write(key: "staffId", value: "$staffId");
  }
  Future setuser(var user) async {
    await storage.write(key: "user", value: "$user");
  }

  Future getuser() async {
    var user = await storage.read(key: "user");
    return user;
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

  Future setDailyCalls(var dailyCalls) async {
    await storage.write(key: "dailyCalls", value: "$dailyCalls");
  }

  Future getDailyCalls() async {
    var dailyCalls = await storage.read(key: "dailyCalls");
    return dailyCalls;
  }

  Future setfdfmcreate(var setfdfm) async {
    await storage.write(key: "fdfm", value: "$setfdfm");
  }

  Future getfdfmcreate() async {
    var fdfm = await storage.read(key: "fdfm");
    return fdfm;
  }

}
