import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DynamicValidator {
  static String? getTextFieldValidation(
      {required String fieldName,
      String? value,
      bool? mandatoryField,
      String? displayNameForUI}) {
    if (mandatoryField ?? false) {
      if (value == null || value.isEmpty) {
        return 'Please enter ${displayNameForUI ?? ""}';
      }
    }

    if (fieldName == 'phone') {
      if (value.toString().length != 10) {
        return 'Mobile number should be 10 digit';
      }
    } else if (fieldName == 'age') {
      if (value!.isNotEmpty) {
        if (value.length != 2) {
          return 'Age should be 2 digit';
        } else {
          return null;
        }
      }
    } else if (fieldName == 'pinCode') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 6) {
          return 'Pin code should be 6 digit';
        }
      }
    } else if (fieldName == 'whatsappNo') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 10) {
          return 'Whatsapp No should be 10 digit';
        }
      }
    } else if (fieldName == 'aadhaarNumber') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 12) {
          return 'Aadhaar Number should be 12 digit';
        }
      }
    } else if (fieldName == 'landline') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 8) {
          return 'Landline Number should be 8 digit';
        }
      }
    } else if (fieldName == 'std_code') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 5) {
          return 'STD code Number should be 5 digit';
        }
      }
    } else if (fieldName == 'primary_member_id') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 10) {
          return 'Primary Member Id should be 10 digit';
        }
      }
    } else if (fieldName == 'pannaNumber') {
      if (value!.isNotEmpty) {
        if (value.toString().length > 3) {
          return 'Panna number maximum 3 digit';
        }
      }
    } else if (fieldName == 'email') {
      if (value!.isNotEmpty) {
        if (!RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value)) {
          return 'Please Enter Valid Email';
        }
      }
    } else if (fieldName == "voterId") {
      if (value!.isNotEmpty) {
        RegExp regex = RegExp(r'^([a-zA-Z]){3}([0-9]){7}$');
        if (!regex.hasMatch(value)) {
          return 'Enter valid voter Id';
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  }

  static addTextInputFormatters({required String fieldType}) {
    if (fieldType == 'phone') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '*#########',
            filter: {"*": RegExp(r'^[5-9]'), "#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'whatsappNo') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '*#########',
            filter: {"*": RegExp(r'^[5-9]'), "#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'age') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'std_code') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '#####',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'landline') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '########',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'pinCode') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '######',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'primary_member_id') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '##########',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == "aadhaarNumber") {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '############',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == "pannaNumber") {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '###',
            filter: {"#": RegExp(r'[1-9]')},
            type: MaskAutoCompletionType.lazy)
      ];
    }
  }
}
