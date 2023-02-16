import '../network/model/category_model.dart';

class DynamicUIHandler {
  static List<String> dropdowns = [
    "designation",
    "categoryId",
    "caste",
    "religionId",
    "professionId",
    "educationId",
    "blood_group",
    "district",
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
    "ration_url",
    "ration_card_url"
  ];
  static List<String> radioButton = ["gender"];

  static List<String> imagePicker = ["photo"];

  static List<DropdownData> bloodGroupList = [
    DropdownData(id: 1, name: "A+"),
    DropdownData(id: 2, name: "O+"),
    DropdownData(id: 3, name: "B+"),
    DropdownData(id: 4, name: "AB+"),
    DropdownData(id: 5, name: "A-"),
    DropdownData(id: 6, name: "O-"),
    DropdownData(id: 7, name: "B-"),
    DropdownData(id: 8, name: "AB-"),
  ];
}
