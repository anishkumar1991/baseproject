class DynamicUIHandler {
  static List<String> dropdowns = [
    "designation",
    "categoryId",
    "caste",
    "religionId",
    "professionId",
    "educationId",
  ];
  static List<String> textfield = [
    "name",
    "relation_name",
    "phone",
    "primary_member_id",
    "age",
    "email",
    "address",
    "village",
    "tehsil",
    "district",
    "pinCode",
    "qualification",
    "voterId",
    "aadhaarNumber",
    "rationCardNumber",

    ///TODO : This parameter is not show in UI part
    /*  "assembly_constituency",
    "booth",*/
    "std_code",
    "landline",
    "whatsappNo",
    "pannaNumber",
    "facebook_profile",
    "facebookProfile",
    "instagramProfile",
    "twitterProfile",
    "linkedinProfile",
    "Salutation",
    "sub_caste",
    "blood_group"
  ];
  static List<String> multiSelectionField = ["car", "bike", "smartphone"];

  static List<String> calenderView = ["dob"];

  static List<String> filePicker = [
    "aadhaarNumber",
    "voterId",
    "rationCardNumber"
  ];
  static List<String> filePickerUrl = [
    "aadhaar_url",
    "voter_url",
    "ration_url"
  ];
  static List<String> radioButton = ["gender"];

  static List<String> imagePicker = ["photo"];
}
