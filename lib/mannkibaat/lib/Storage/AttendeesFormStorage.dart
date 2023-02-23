import 'package:get_storage/get_storage.dart';

class AttendeeStorageService {
  static String totalAttendees = "totalAttendees";
  static String address = "address";
  static String description = "description";
  static String image1url = "image1url";
  static String image2url = "image2url";
  static String stateName = "stateName";
  static String vidhanSabhaName = "vidhanSabhaName";
  static String acId = "acId";
  static String skId = "skId";
  static String boothName = "boothName";

  static GetStorage storage = GetStorage();

  static setstateName(String token) async {
    await storage.write(stateName, token);
  }

  static String? getstateName() {
    return storage.read(stateName);
  }

  static setvidhanSabhaName(String token) async {
    await storage.write(vidhanSabhaName, token);
  }

  static String? getvidhanSabhaName() {
    return storage.read(vidhanSabhaName);
  }

  static settotalAttendees(String token) async {
    await storage.write(totalAttendees, token);
  }

  static String? gettotalAttendees() {
    return storage.read(totalAttendees);
  }

  static setaddress(String token) async {
    await storage.write(address, token);
  }

  static String? getaddress() {
    return storage.read(address);
  }

  static setdescription(String id) async {
    await storage.write(description, id);
  }

  static getdescription() {
    return storage.read(description);
  }

  static setimage1url(String token) async {
    await storage.write(image1url, token);
  }

  static String? getimage1url() {
    return storage.read(image1url);
  }

  static setimage2url(String token) async {
    await storage.write(image2url, token);
  }

  static String? getimage2url() {
    return storage.read(image2url);
  }

  static setacId(String token) async {
    await storage.write(acId, token);
  }

  static String? getacId() {
    return storage.read(acId);
  }

  static setskId(String token) async {
    await storage.write(skId, token);
  }

  static String? getskId() {
    return storage.read(skId);
  }

  static setboothName(String token) async {
    await storage.write(boothName, token);
  }

  static String? getboothName() {
    return storage.read(boothName);
  }
}
