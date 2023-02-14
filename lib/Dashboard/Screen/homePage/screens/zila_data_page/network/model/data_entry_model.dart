class DataEntryModel {
  bool? success;
  Data? data;
  String? message;

  DataEntryModel({this.success, this.data, this.message});

  DataEntryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<KaryakartaData>? data;
  int? total;

  Data({this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <KaryakartaData>[];
      json['data'].forEach((v) {
        data!.add(KaryakartaData.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class KaryakartaData {
  int? id;
  String? name;
  String? hindiName;
  String? englishName;
  String? relationName;
  String? phone;
  String? ac;
  String? status;
  String? mandalZilaName;
  dynamic acId;
  String? salutation;
  String? smartphone;
  String? qualification;
  String? subCaste;
  String? noOfTerms;
  String? ministerStatus;
  String? acName;
  String? levelName;
  dynamic levelNameId;
  dynamic levelId;
  String? level;
  String? location;
  String? unit;
  String? subUnit;
  dynamic subUnitId;
  int? designation;
  String? designationName;
  String? designationNameSearchPerson;
  String? category;
  dynamic caste;
  String? casteName;
  String? education;
  String? profession;
  String? state;
  String? primaryMemberId;
  dynamic age;
  String? gender;
  String? dob;
  String? whatsappNo;
  String? email;
  String? address;
  String? village;
  String? tehsil;
  String? district;
  String? pinCode;
  String? booth;
  dynamic primaryMemberId1;
  dynamic activeMemberId;
  String? partyDistrict;
  dynamic partyDistrictId;
  String? partyMandal;
  dynamic partyMandalId;
  dynamic voterId;
  dynamic educationId;
  dynamic professionId;
  dynamic categoryId;
  String? stdCode;
  String? landline;
  String? bike;
  String? car;
  dynamic createdById;
  String? createdByName;
  String? createdAt;
  String? pannaNumber;
  String? aadhaarNumber;
  String? rationCardNumber;
  String? linkedinProfile;
  String? instagramProfile;
  String? facebookProfile;
  String? twitterProfile;
  String? paName;
  String? paNumber;
  dynamic nativeState;
  String? votingState;
  String? termStart;
  String? termEnd;
  String? currentResponsibility;
  String? pastResponsibilityGov;
  String? pastResponsibilityParty;
  String? photo;
  String? aadhaarUrl;
  String? voterUrl;
  String? rationCardUrl;
  String? delhiAddress;
  String? isElectedRepresentative;
  String? wardNumber;
  String? wardName;
  String? updatedAt;
  String? bloodGroup;
  dynamic qcById;
  String? qcAt;
  dynamic religionId;
  dynamic unitId;
  dynamic countryStateId;
  dynamic typeId;
  String? religion;
  dynamic zilaId;
  dynamic locationAcId;
  String? otpStatus;

  KaryakartaData(
      {this.id,
      this.name,
      this.hindiName,
      this.englishName,
      this.relationName,
      this.phone,
      this.ac,
      this.status,
      this.mandalZilaName,
      this.acId,
      this.salutation,
      this.smartphone,
      this.qualification,
      this.subCaste,
      this.noOfTerms,
      this.ministerStatus,
      this.acName,
      this.levelName,
      this.levelNameId,
      this.levelId,
      this.level,
      this.location,
      this.unit,
      this.subUnit,
      this.subUnitId,
      this.designation,
      this.designationName,
      this.designationNameSearchPerson,
      this.category,
      this.caste,
      this.casteName,
      this.education,
      this.profession,
      this.state,
      this.primaryMemberId,
      this.age,
      this.gender,
      this.dob,
      this.whatsappNo,
      this.email,
      this.address,
      this.village,
      this.tehsil,
      this.district,
      this.pinCode,
      this.booth,
      this.primaryMemberId1,
      this.activeMemberId,
      this.partyDistrict,
      this.partyDistrictId,
      this.partyMandal,
      this.partyMandalId,
      this.voterId,
      this.educationId,
      this.professionId,
      this.categoryId,
      this.stdCode,
      this.landline,
      this.bike,
      this.car,
      this.createdById,
      this.createdByName,
      this.createdAt,
      this.pannaNumber,
      this.aadhaarNumber,
      this.rationCardNumber,
      this.linkedinProfile,
      this.instagramProfile,
      this.facebookProfile,
      this.twitterProfile,
      this.paName,
      this.paNumber,
      this.nativeState,
      this.votingState,
      this.termStart,
      this.termEnd,
      this.currentResponsibility,
      this.pastResponsibilityGov,
      this.pastResponsibilityParty,
      this.photo,
      this.aadhaarUrl,
      this.voterUrl,
      this.rationCardUrl,
      this.delhiAddress,
      this.isElectedRepresentative,
      this.wardNumber,
      this.wardName,
      this.updatedAt,
      this.bloodGroup,
      this.qcById,
      this.qcAt,
      this.religionId,
      this.unitId,
      this.countryStateId,
      this.typeId,
      this.religion,
      this.zilaId,
      this.locationAcId,
      this.otpStatus});

  KaryakartaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hindiName = json['hindi_name'];
    englishName = json['english_name'];
    relationName = json['relation_name'];
    phone = json['phone'];
    ac = json['ac'];
    status = json['status'];
    mandalZilaName = json['mandal_zila_name'];
    acId = json['acId'];
    salutation = json['salutation'];
    smartphone = json['smartphone'];
    qualification = json['qualification'];
    subCaste = json['sub_caste'];
    noOfTerms = json['no_of_terms'];
    ministerStatus = json['minister_status'];
    acName = json['acName'];
    levelName = json['level_name'];
    levelNameId = json['level_name_id'];
    levelId = json['level_id'];
    level = json['level'];
    location = json['location'];
    unit = json['unit'];
    subUnit = json['sub_unit'];
    subUnitId = json['sub_unit_id'];
    designation = json['designation'];
    designationName = json['designation_name'];
    designationNameSearchPerson = json['designation_name_search_person'];
    category = json['category'];
    caste = json['caste'];
    casteName = json['casteName'];
    education = json['education'];
    profession = json['profession'];
    state = json['state'];
    primaryMemberId = json['primary_member_id'];
    age = json['age'];
    gender = json['gender'];
    dob = json['dob'];
    whatsappNo = json['whatsappNo'];
    email = json['email'];
    address = json['address'];
    village = json['village'];
    tehsil = json['tehsil'];
    district = json['district'];
    pinCode = json['pinCode'];
    booth = json['booth'];
    primaryMemberId = json['primaryMemberId'];
    activeMemberId = json['active_member_id'];
    partyDistrict = json['party_district'];
    partyDistrictId = json['party_district_id'];
    partyMandal = json['party_mandal'];
    partyMandalId = json['party_mandal_id'];
    voterId = json['voterId'];
    educationId = json['educationId'];
    professionId = json['professionId'];
    categoryId = json['categoryId'];
    stdCode = json['std_code'];
    landline = json['landline'];
    bike = json['bike'];
    car = json['car'];
    createdById = json['createdById'];
    createdByName = json['createdByName'];
    createdAt = json['created_at'];
    pannaNumber = json['pannaNumber'];
    aadhaarNumber = json['aadhaarNumber'];
    rationCardNumber = json['rationCardNumber'];
    linkedinProfile = json['linkedinProfile'];
    instagramProfile = json['instagramProfile'];
    facebookProfile = json['facebookProfile'];
    twitterProfile = json['twitterProfile'];
    paName = json['pa_name'];
    paNumber = json['pa_number'];
    nativeState = json['native_state'];
    votingState = json['voting_state'];
    termStart = json['term_start'];
    termEnd = json['term_end'];
    currentResponsibility = json['current_responsibility'];
    pastResponsibilityGov = json['past_responsibility_gov'];
    pastResponsibilityParty = json['past_responsibility_party'];
    photo = json['photo'];
    aadhaarUrl = json['aadhaar_url'];
    voterUrl = json['voter_url'];
    rationCardUrl = json['ration_card_url'];
    delhiAddress = json['delhi_address'];
    isElectedRepresentative = json['is_elected_representative'];
    wardNumber = json['ward_number'];
    wardName = json['ward_name'];
    updatedAt = json['updated_at'];
    bloodGroup = json['blood_group'];
    qcById = json['qc_by_id'];
    qcAt = json['qc_at'];
    religionId = json['religionId'];
    unitId = json['unit_id'];
    countryStateId = json['country_state_id'];
    typeId = json['type_id'];
    religion = json['religion'];
    zilaId = json['zila_id'];
    locationAcId = json['location_ac_id'];
    otpStatus = json['otp_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['hindi_name'] = hindiName;
    data['english_name'] = englishName;
    data['relation_name'] = relationName;
    data['phone'] = phone;
    data['ac'] = ac;
    data['status'] = status;
    data['mandal_zila_name'] = mandalZilaName;
    data['acId'] = acId;
    data['salutation'] = salutation;
    data['smartphone'] = smartphone;
    data['qualification'] = qualification;
    data['sub_caste'] = subCaste;
    data['no_of_terms'] = noOfTerms;
    data['minister_status'] = ministerStatus;
    data['acName'] = acName;
    data['level_name'] = levelName;
    data['level_name_id'] = levelNameId;
    data['level_id'] = levelId;
    data['level'] = level;
    data['location'] = location;
    data['unit'] = unit;
    data['sub_unit'] = subUnit;
    data['sub_unit_id'] = subUnitId;
    data['designation'] = designation;
    data['designation_name'] = designationName;
    data['designation_name_search_person'] = designationNameSearchPerson;
    data['category'] = category;
    data['caste'] = caste;
    data['casteName'] = casteName;
    data['education'] = education;
    data['profession'] = profession;
    data['state'] = state;
    data['primary_member_id'] = primaryMemberId;
    data['age'] = age;
    data['gender'] = gender;
    data['dob'] = dob;
    data['whatsappNo'] = whatsappNo;
    data['email'] = email;
    data['address'] = address;
    data['village'] = village;
    data['tehsil'] = tehsil;
    data['district'] = district;
    data['pinCode'] = pinCode;
    data['booth'] = booth;
    data['primaryMemberId'] = primaryMemberId;
    data['active_member_id'] = activeMemberId;
    data['party_district'] = partyDistrict;
    data['party_district_id'] = partyDistrictId;
    data['party_mandal'] = partyMandal;
    data['party_mandal_id'] = partyMandalId;
    data['voterId'] = voterId;
    data['educationId'] = educationId;
    data['professionId'] = professionId;
    data['categoryId'] = categoryId;
    data['std_code'] = stdCode;
    data['landline'] = landline;
    data['bike'] = bike;
    data['car'] = car;
    data['createdById'] = createdById;
    data['createdByName'] = createdByName;
    data['created_at'] = createdAt;
    data['pannaNumber'] = pannaNumber;
    data['aadhaarNumber'] = aadhaarNumber;
    data['rationCardNumber'] = rationCardNumber;
    data['linkedinProfile'] = linkedinProfile;
    data['instagramProfile'] = instagramProfile;
    data['facebookProfile'] = facebookProfile;
    data['twitterProfile'] = twitterProfile;
    data['pa_name'] = paName;
    data['pa_number'] = paNumber;
    data['native_state'] = nativeState;
    data['voting_state'] = votingState;
    data['term_start'] = termStart;
    data['term_end'] = termEnd;
    data['current_responsibility'] = currentResponsibility;
    data['past_responsibility_gov'] = pastResponsibilityGov;
    data['past_responsibility_party'] = pastResponsibilityParty;
    data['photo'] = photo;
    data['aadhaar_url'] = aadhaarUrl;
    data['voter_url'] = voterUrl;
    data['ration_card_url'] = rationCardUrl;
    data['delhi_address'] = delhiAddress;
    data['is_elected_representative'] = isElectedRepresentative;
    data['ward_number'] = wardNumber;
    data['ward_name'] = wardName;
    data['updated_at'] = updatedAt;
    data['blood_group'] = bloodGroup;
    data['qc_by_id'] = qcById;
    data['qc_at'] = qcAt;
    data['religionId'] = religionId;
    data['unit_id'] = unitId;
    data['country_state_id'] = countryStateId;
    data['type_id'] = typeId;
    data['religion'] = religion;
    data['zila_id'] = zilaId;
    data['location_ac_id'] = locationAcId;
    data['otp_status'] = otpStatus;
    return data;
  }
}
