class CitiesList {
  List<Table1>? table1;
  List<StaffDetails>? staffDetails;
  List<NWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS>?
  nWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS;

  CitiesList(
      {this.table1,
        this.staffDetails,
        this.nWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS});

  CitiesList.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      table1 = <Table1>[];
      json['Table1'].forEach((v) {
        table1!.add(new Table1.fromJson(v));
      });
    }
    if (json['Staff_Details'] != null) {
      staffDetails = <StaffDetails>[];
      json['Staff_Details'].forEach((v) {
        staffDetails!.add(new StaffDetails.fromJson(v));
      });
    }
    if (json['NWT_SETUP_FDFM_CREATION_ALLOWED_FOR_HOW_MANY_BACK_DAYS'] !=
        null) {
      nWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS =
      <NWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS>[];
      json['NWT_SETUP_FDFM_CREATION_ALLOWED_FOR_HOW_MANY_BACK_DAYS']
          .forEach((v) {
        nWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS!
            .add(new NWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table1 != null) {
      data['Table1'] = this.table1!.map((v) => v.toJson()).toList();
    }
    if (this.staffDetails != null) {
      data['Staff_Details'] =
          this.staffDetails!.map((v) => v.toJson()).toList();
    }
    if (this.nWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS != null) {
      data['NWT_SETUP_FDFM_CREATION_ALLOWED_FOR_HOW_MANY_BACK_DAYS'] = this
          .nWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class Table1 {
  String? cODE;
  String? nAME;

  Table1({this.cODE, this.nAME});

  Table1.fromJson(Map<String, dynamic> json) {
    cODE = json['CODE'];
    nAME = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODE'] = this.cODE;
    data['NAME'] = this.nAME;
    return data;
  }
}

class StaffDetails {
  String? eMPLMOBILENO;
  String? eMPLFULLNAME;
  String? rOLE;

  StaffDetails({this.eMPLMOBILENO, this.eMPLFULLNAME, this.rOLE});

  StaffDetails.fromJson(Map<String, dynamic> json) {
    eMPLMOBILENO = json['EMPL_MOBILE_NO'];
    eMPLFULLNAME = json['EMPL_FULL_NAME'];
    rOLE = json['ROLE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMPL_MOBILE_NO'] = this.eMPLMOBILENO;
    data['EMPL_FULL_NAME'] = this.eMPLFULLNAME;
    data['ROLE'] = this.rOLE;
    return data;
  }
}

class NWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS {
  String? nWTSETDEFAULTVALUE;

  NWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS({this.nWTSETDEFAULTVALUE});

  NWTSETUPFDFMCREATIONALLOWEDFORHOWMANYBACKDAYS.fromJson(
      Map<String, dynamic> json) {
    nWTSETDEFAULTVALUE = json['NWT_SET_DEFAULT_VALUE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NWT_SET_DEFAULT_VALUE'] = this.nWTSETDEFAULTVALUE;
    return data;
  }
}