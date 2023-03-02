import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/l10n.dart';
import '../../sangathan_details/cubit/sangathan_detail_cubit.dart';
import '../cubit/zila_data_cubit.dart';

class DropdownHandler {
  static dynamicSangathanDropdown(BuildContext context, String type, int locationId, String locationType) {
    final cubit = context.read<SangathanDetailsCubit>();
    if (locationType == gettingLocationTypeForCondition(type)) {
      context.read<ZilaDataCubit>().getPartyZila(
          remainingURL: "data/allotted_locations?client_id=${cubit.clientId}&app_permission_id=${cubit.permissionId}",
          type: type);
    } else {
      if (type == "Mandal" || type == "Panna") {
        if (locationType == "Zila" || locationType == "Booth") {
          context.read<ZilaDataCubit>().getPartyZila(
              remainingURL:
                  "data/allotted_locations?client_id=${cubit.clientId}&app_permission_id=${cubit.permissionId}",
              type: type);
        } else {
          context.read<ZilaDataCubit>().getPartyZila(
              remainingURL:
                  "data/required_locations?location_type=$locationType&location_id=$locationId&required_location_type=${getLevelType(type)}",
              type: type);
        }
      } else {
        context.read<ZilaDataCubit>().getPartyZila(
            remainingURL:
                "data/required_locations?location_type=$locationType&location_id=$locationId&required_location_type=${getLevelType(type)}",
            type: type);
      }
    }
  }

  static dynamicDependentDropdown(
      {required BuildContext context,
      required String type,
      required String id,
      required int locationId,
      required String locationType}) {
    if (type == "Mandal") {
      context.read<ZilaDataCubit>().getDependentDropdownData(
          remainingURL:
              "data/required_locations?location_type=$locationType&location_id=$locationId&required_location_type=Mandal&zila_id=$id",
          type: type);
    } else if (type == "Booth" || type == "Panna") {
      context.read<ZilaDataCubit>().getDependentDropdownData(
          remainingURL:
              "data/required_locations?location_type=$locationType&location_id=$locationId&required_location_type=Booth&ac_id=$id",
          type: type);
    } else if (type == "Shakti Kendra") {
      context.read<ZilaDataCubit>().getDependentDropdownData(
          remainingURL:
              "data/required_locations?location_type=$locationType&location_id=$locationId&required_location_type=ShaktiKendra&ac_id=$id",
          type: type);
    }
  }

  static getLevelType(String type) {
    if (type == "Pradesh") {
      return "CountryState";
    } else if (type == "Zila" || type == "Mandal") {
      return "Zila";
    } else if (type == "Vibhag") {
      return "StateZone";
    } else if (type == "Lok Sabha") {
      return "ParliamentaryConstituency";
    } else if (type == "Vidhan Sabha" || type == "Panna" || type == "Shakti Kendra" || type == "Booth") {
      return "AssemblyConstituency";
    }
  }

  static gettingLocationTypeForCondition(String type) {
    if (type == "Pradesh") {
      return "CountryState";
    } else if (type == "Zila") {
      return "Zila";
    } else if (type == "Mandal") {
      return "Mandal";
    } else if (type == "Vibhag") {
      return "StateZone";
    } else if (type == "Lok Sabha") {
      return "ParliamentaryConstituency";
    } else if (type == "Vidhan Sabha") {
      return "AssemblyConstituency";
    } else if (type == "Shakti Kendra") {
      return "ShaktiKendra";
    } else if (type == "Booth" || type == "Panna") {
      return "Booth";
    } else {
      return type;
    }
  }

  static gettingReverseLocationTypeForCondition(String type) {
    if (type == "CountryState") {
      return "Pradesh";
    } else if (type == "Zila") {
      return "Zila";
    } else if (type == "Mandal") {
      return "Mandal";
    } else if (type == "Vibhag") {
      return "StateZone";
    } else if (type == "ParliamentaryConstituency") {
      return "Lok Sabha";
    } else if (type == "AssemblyConstituency") {
      return "Vidhan Sabha";
    } else if (type == "Panna") {
      return "Panna";
    } else if (type == "ShaktiKendra") {
      return "Shakti Kendra";
    } else if (type == "Booth") {
      return "Booth";
    } else {
      return type;
    }
  }

  static mainDropdownName(String type, BuildContext context) {
    if (type == "Pradesh") {
      return "Pradesh";
    } else if (type == "Zila" || type == "Mandal") {
      return "Zila";
    } else if (type == "Vibhag") {
      return "Vibhag";
    } else if (type == "Lok Sabha") {
      return "Lok Sabha";
    } else if (type == "Vidhan Sabha" || type == "Panna" || type == "Shakti Kendra" || type == "Booth") {
      return S.of(context).vidhanSabha;
    } else {
      return type;
    }
  }

  static dependentDropdownName(String type, BuildContext context) {
    if (type == "Mandal") {
      return "Mandal";
    } else if (type == "Booth" || type == "Panna") {
      return S.of(context).booth;
    } else if (type == "Shakti Kendra") {
      return "Shakti Kendra";
    } else {
      return type;
    }
  }
}
