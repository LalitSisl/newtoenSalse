class SubAreaCode {
  String? subAreaCode;
  String? subAreaDesc;

  SubAreaCode({this.subAreaCode, this.subAreaDesc});

  SubAreaCode.fromJson(Map<String, dynamic> json) {
    subAreaCode = json['sub_area_code'];
    subAreaDesc = json['sub_area_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_area_code'] = this.subAreaCode;
    data['sub_area_desc'] = this.subAreaDesc;
    return data;
  }
}