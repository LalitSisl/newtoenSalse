class InstructionModel {
  String? mEMOTEXT;
  String? mEMODATE;

  InstructionModel({this.mEMOTEXT, this.mEMODATE});

  InstructionModel.fromJson(Map<String, dynamic> json) {
    mEMOTEXT = json['MEMO_TEXT'];
    mEMODATE = json['MEMO_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MEMO_TEXT'] = this.mEMOTEXT;
    data['MEMO_DATE'] = this.mEMODATE;
    return data;
  }
}

