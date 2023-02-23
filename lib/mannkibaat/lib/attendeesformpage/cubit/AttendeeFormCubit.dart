import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../Storage/AttendeesFormStorage.dart';
import '../network/model/Booth.dart';
import '../network/services/FetchAPI.dart';
import 'AttendeeFormState.dart';

class AttendeeFormCubit extends Cubit<AttendeeFormState> {
  final api = FetchAPI(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true))));
  String? tempimage1;
  String? tempimage2;

  AttendeeFormCubit() : super(InitialState()) {}

  void selectedImage1(File file) async {
    emit(Image1UploadingState());
    UploadTask uploadTask1 = FirebaseStorage.instance
        .ref()
        .child("Image1")
        .child(const Uuid().v1())
        .putFile(file);

    TaskSnapshot taskSnapshot1 = await uploadTask1;
    String downloadUrlImage1 = await taskSnapshot1.ref.getDownloadURL();

    tempimage1 = downloadUrlImage1;
    print(downloadUrlImage1);
    emit(Image1SelectedState());
  }

  void selectedImage2(File file) async {
    emit(Image2UploadingState());

    UploadTask uploadTask1 = FirebaseStorage.instance
        .ref()
        .child("Image2")
        .child(const Uuid().v1())
        .putFile(file);

    TaskSnapshot taskSnapshot1 = await uploadTask1;
    String downloadUrlImage2 = await taskSnapshot1.ref.getDownloadURL();

    tempimage2 = downloadUrlImage2;
    emit(Image2SelectedState());
  }

  Future fetchAcId() async {
    try {
      String? _auth =
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.1aBzmXruUAVV7ancpI1gu6GhOSso9xUqONf2DZ9ICmA";
      print(_auth);
      final res =
          await api.fetchAc(_auth, AttendeeStorageService.getacId().toString());
      if (res.response.statusCode == 200) {
        print("sk id fethcig working");
        Booth model = Booth.fromJson(res.data);
        print('profile res =${res.response.statusCode}');
        // print("232ejri3or "+model.data.first.name);
        var jsonsDataString = json.decode(json.encode(res.response
            .data)); // toString of Response's body is assigned to jsonDataString

        return res;
      } else {
        print("not api");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }

  Future fetchBooth() async {
    try {
      String? _auth =
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.1aBzmXruUAVV7ancpI1gu6GhOSso9xUqONf2DZ9ICmA";
      print(_auth);
      final res = await api.fetchBooth(
          _auth, AttendeeStorageService.getskId().toString());
      if (res.response.statusCode == 200) {
        print("booth fetching working");
        Booth model = Booth.fromJson(res.data);
        print('profile res =${res.response.statusCode}');
        // print("232ejri3or "+model.data.first.name);
        var jsonsDataString = json.decode(json.encode(res.response
            .data)); // toString of Response's body is assigned to jsonDataString

        return res;
      } else {
        print("not api");
        // State? model = States.fromJson(res.data);
        // emit(LoginFaieldState(model.message ?? ''));
      }
    } on Exception catch (e) {
      print(e.toString());
      // LoginFaieldState(e.toString());
    }
  }
}
