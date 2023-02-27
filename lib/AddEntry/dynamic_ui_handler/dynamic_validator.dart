import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sangathan/generated/l10n.dart';

class DynamicValidator {
  static String? getTextFieldValidation(
      {required String fieldName,
      String? value,
      bool? mandatoryField,
      required BuildContext context,
      String? displayNameForUI}) {
    if (mandatoryField ?? false) {
      if (value == null || value.isEmpty) {
        return '${S.of(context).please} ${displayNameForUI ?? ""} ${S.of(context).enter}';
      }
    }

    if (fieldName == 'phone') {
      if (value.toString().length != 10) {
        return S.of(context).enterPhoneNumber;
      }
    } else if (fieldName == 'age') {
      if (value!.isNotEmpty) {
        if (value.length != 2) {
          return S.of(context).ageError;
        } else {
          return null;
        }
      }
    } else if (fieldName == 'pinCode') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 6) {
          return S.of(context).pincode;
        }
      }
    } else if (fieldName == 'whatsappNo') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 10) {
          return S.of(context).whatsappNumber;
        }
      }
    } else if (fieldName == 'aadhaarNumber') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 12) {
          return S.of(context).aadharNumber;
        }
      }
    } else if (fieldName == 'landline') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 8) {
          return S.of(context).landlineNumber;
        }
      }
    } else if (fieldName == 'std_code') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 5) {
          return S.of(context).stdCodeNumber;
        }
      }
    } else if (fieldName == 'primary_member_id') {
      if (value!.isNotEmpty) {
        if (value.toString().length != 10) {
          return S.of(context).primaryMemberId;
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
          return S.of(context).emailAddress;
        }
      }
    } else if (fieldName == "voterId") {
      if (value!.isNotEmpty) {
        RegExp regex = RegExp(r'^([a-zA-Z]){3}([0-9]){7}$');
        if (!regex.hasMatch(value)) {
          return S.of(context).voterId;
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
    return null;
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
        MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'std_code') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(mask: '#####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'landline') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'pinCode') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(mask: '######', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == 'primary_member_id') {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(mask: '##########', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == "aadhaarNumber") {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(mask: '############', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
      ];
    } else if (fieldType == "pannaNumber") {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        MaskTextInputFormatter(
            mask: '*##', filter: {"*": RegExp(r'^[1-9]$'), "#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
      ];
    }
  }

  static String? dropdownValidation(
      {required BuildContext context, required String displayNameForUI, required bool mandatoryField, String? value}) {
    if (mandatoryField) {
      if (value == null || value.isEmpty) {
        return '${S.of(context).please} $displayNameForUI ${S.of(context).enter}';
      }
    }
    return null;
  }
}
