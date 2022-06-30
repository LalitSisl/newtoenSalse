class DistributedBean {
  List<Report>? report;

  DistributedBean( {this.report});

  DistributedBean.fromJson(Map<String, dynamic> json) {
    if (json['Report'] != null) {
      report = <Report>[];
      json['Report'].forEach((v) {
        report!.add(new Report.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.report != null) {
      data['Report'] = this.report!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Report {
  String? dISTRIBUTORID;
  String? dISTRIBUTORNAME;
  String? rETAILERID;
  String? rETAILERNAME;

  Report(
      {this.dISTRIBUTORID,
        this.dISTRIBUTORNAME,
        this.rETAILERID,
        this.rETAILERNAME});

  Report.fromJson(Map<String, dynamic> json) {
    dISTRIBUTORID = json['DISTRIBUTOR_ID'];
    dISTRIBUTORNAME = json['DISTRIBUTOR_NAME'];
    rETAILERID = json['RETAILER_ID'];
    rETAILERNAME = json['RETAILER_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DISTRIBUTOR_ID'] = this.dISTRIBUTORID;
    data['DISTRIBUTOR_NAME'] = this.dISTRIBUTORNAME;
    data['RETAILER_ID'] = this.rETAILERID;
    data['RETAILER_NAME'] = this.rETAILERNAME;
    return data;
  }
}