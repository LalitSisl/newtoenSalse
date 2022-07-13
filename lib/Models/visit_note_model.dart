class VisitNoteModel {
  String? date;
  String? remarks;
  String? eMPLOYEE;
  String? visitType;

  VisitNoteModel({this.date, this.remarks, this.eMPLOYEE, this.visitType});

  VisitNoteModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    remarks = json['Remarks'];
    eMPLOYEE = json['EMPLOYEE'];
    visitType = json['VisitType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['Remarks'] = this.remarks;
    data['EMPLOYEE'] = this.eMPLOYEE;
    data['VisitType'] = this.visitType;
    return data;
  }
}

