class FDFMBean {
 String? sStaffID;
 String? sMobile;
 String? sPlanDate;
 String? sClient;
 String? sDSP;
 String? sCity;
 String? supportedBy;
 String? todate;
 String? firmType;
 String? type;

 FDFMBean(
     {this.sStaffID,
      this.sMobile,
      this.sPlanDate,
      this.sClient,
      this.sDSP,
      this.sCity,
      this.supportedBy,
      this.todate,
      this.firmType,
      this.type});

 FDFMBean.fromJson(Map<String, dynamic> json) {
  sStaffID = json['_StaffID'];
  sMobile = json['_Mobile'];
  sPlanDate = json['_PlanDate'];
  sClient = json['_Client'];
  sDSP = json['_DSP'];
  sCity = json['_City'];
  supportedBy = json['Supported_By'];
  todate = json['Todate'];
  firmType = json['FirmType'];
  type = json['type'];
 }

  get dsp => null;

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['_StaffID'] = this.sStaffID;
  data['_Mobile'] = this.sMobile;
  data['_PlanDate'] = this.sPlanDate;
  data['_Client'] = this.sClient;
  data['_DSP'] = this.sDSP;
  data['_City'] = this.sCity;
  data['Supported_By'] = this.supportedBy;
  data['Todate'] = this.todate;
  data['FirmType'] = this.firmType;
  data['type'] = this.type;
  return data;
 }
}