import '../cubit/add_entry_cubit.dart';

class FieldHandler extends AddEntryCubit {
  static getDropdownList(String dropdownType, AddEntryCubit cubit) {
    if (dropdownType == "designation") {
      return cubit.designationData;
    } else if (dropdownType == "category") {
      return cubit.categoryData;
    } else if (dropdownType == "caste") {
      return cubit.castData;
    } else if (dropdownType == "qualification") {
      return cubit.qualificationData;
    } else if (dropdownType == "religion") {
      return cubit.religionData;
    } else if (dropdownType == "profession") {
      return cubit.professionData;
    } else {
      return [];
    }
  }

  /// Here getting specify dropdown selected value
  static getDropdownSelected(String dropdownType, AddEntryCubit cubit) {
    if (dropdownType == "designation") {
      return cubit.designationSelected;
    } else if (dropdownType == "category") {
      return cubit.categorySelected;
    } else if (dropdownType == "caste") {
      return cubit.castSelected;
    } else if (dropdownType == "qualification") {
      return cubit.qualificationSelected;
    } else if (dropdownType == "religion") {
      return cubit.religionSelected;
    } else if (dropdownType == "profession") {
      return cubit.professionSelected;
    } else {
      return null;
    }
  }

  /// This function call in textfield onChange()
  static onUpdate(
      int index, String val, String fieldName, AddEntryCubit cubit) async {
    int foundKey = -1;
    for (var map in cubit.textFieldControllerData) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      cubit.textFieldControllerData.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "fieldName": fieldName,
      "value": val,
    };
    cubit.textFieldControllerData.add(json);
  }

  /// here get pick image or file  name

  static getFileName(String fieldName, AddEntryCubit cubit) {
    String name = '';
    for (int i = 0; i < cubit.allImagePickerList.length; i++) {
      if (cubit.allImagePickerList[i]["fieldName"] == fieldName) {
        name = cubit.allImagePickerList[i]["value"];
      }
    }
    return name;
  }

  /// here get Field name

  static getFieldName(String fieldName, AddEntryCubit cubit) {
    String name = '';

    for (int i = 0; i < cubit.entryField!.length; i++) {
      if (cubit.entryField![i].formControlName == fieldName) {
        name = cubit.entryField![i].displayNameForUI ?? fieldName;
      }
    }
    return name;
  }

  /// Here getting specify dropdown selected value name
  static getDropdownSelectedValueName(
      String dropdownType, AddEntryCubit cubit) {
    if (dropdownType == "designation") {
      return cubit.designationSelected?.name;
    } else if (dropdownType == "category") {
      return cubit.categorySelected?.name;
    } else if (dropdownType == "caste") {
      return cubit.castSelected?.name;
    } else if (dropdownType == "qualification") {
      return cubit.qualificationSelected?.name;
    } else if (dropdownType == "religion") {
      return cubit.religionSelected?.name;
    } else if (dropdownType == "profession") {
      return cubit.professionSelected?.name;
    } else {
      return null;
    }
  }
}
