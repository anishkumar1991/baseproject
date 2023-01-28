class AddEntryFormStructure {
  bool? success;
  String? message;
  List<DataEntryField>? dataEntryField;
  bool? autofill;

  AddEntryFormStructure(
      {this.success, this.message, this.dataEntryField, this.autofill});

  AddEntryFormStructure.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      dataEntryField = <DataEntryField>[];
      json['data'].forEach((v) {
        dataEntryField!.add(DataEntryField.fromJson(v));
      });
    }
    autofill = json['autofill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (dataEntryField != null) {
      data['data'] = dataEntryField!.map((v) => v.toJson()).toList();
    }
    data['autofill'] = autofill;
    return data;
  }
}

class DataEntryField {
  String? name;
  String? templateName;
  String? formControlName;
  String? fieldName;
  String? displayFieldName;
  int? minWidth;
  int? maxWidth;
  bool? primary;
  int? actualWidth;
  int? widthInTable;
  bool? isInputElement;
  bool? mandatoryField;
  String? displayNameForUI;

  DataEntryField(
      {this.name,
      this.templateName,
      this.formControlName,
      this.fieldName,
      this.displayFieldName,
      this.minWidth,
      this.maxWidth,
      this.primary,
      this.actualWidth,
      this.widthInTable,
      this.isInputElement,
      this.mandatoryField,
      this.displayNameForUI});

  DataEntryField.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    templateName = json['templateName'];
    formControlName = json['formControlName'];
    fieldName = json['fieldName'];
    displayFieldName = json['displayFieldName'];
    minWidth = json['minWidth'];
    maxWidth = json['maxWidth'];
    primary = json['primary'];
    actualWidth = json['actualWidth'];
    widthInTable = json['widthInTable'];
    isInputElement = json['isInputElement'];
    mandatoryField = json['mandatoryField'];
    displayNameForUI = json['displayNameForUI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['templateName'] = templateName;
    data['formControlName'] = formControlName;
    data['fieldName'] = fieldName;
    data['displayFieldName'] = displayFieldName;
    data['minWidth'] = minWidth;
    data['maxWidth'] = maxWidth;
    data['primary'] = primary;
    data['actualWidth'] = actualWidth;
    data['widthInTable'] = widthInTable;
    data['isInputElement'] = isInputElement;
    data['mandatoryField'] = mandatoryField;
    data['displayNameForUI'] = displayNameForUI;
    return data;
  }
}
