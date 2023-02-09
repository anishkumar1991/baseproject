import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/zila_data_cubit.dart';

class DropdownHandler {
  static dynamicSangathanDropdown(BuildContext context, String type) {
    print(type);
    if (type == "Pradesh") {
      context
          .read<ZilaDataCubit>()
          .getPartyZila(remainingURL: "data/allotted_locations", type: type);
    } else if (type == "Zila" || type == "Mandal") {
      context.read<ZilaDataCubit>().getPartyZila(
          remainingURL: "data_entry/party_zilas?state_id=14", type: type);
    } else if (type == "Vibhag") {
      context.read<ZilaDataCubit>().getPartyZila(
          remainingURL:
              "data/required_locations?location_type=CountryState&location_id=14&required_location_type=StateZone",
          type: type);
    } else if (type == "Lok Sabha") {
      context.read<ZilaDataCubit>().getPartyZila(
          remainingURL:
              "data/required_locations?location_type=CountryState&location_id=14&required_location_type=ParliamentaryConstituency",
          type: type);
    } else if (type == "Vidhan Sabha" ||
        type == "Shakti Kendra" ||
        type == "Booth") {
      context.read<ZilaDataCubit>().getPartyZila(
          remainingURL:
              "data/required_locations?location_type=CountryState&location_id=14&required_location_type=AssemblyConstituency",
          type: type);
    }
  }

  static dynamicDependentDropdown(
      BuildContext context, String type, String id) {
    if (type == "Mandal") {
      context.read<ZilaDataCubit>().getDependentDropdownData(
          remainingURL:
              "data/required_locations?location_type=CountryState&location_id=14&required_location_type=Mandal&zila_id=$id",
          type: type);
    } else if (type == "Booth") {
      context.read<ZilaDataCubit>().getDependentDropdownData(
          remainingURL:
              "data/required_locations?location_type=CountryState&location_id=14&required_location_type=Booth&ac_id=$id",
          type: type);
    } else if (type == "Shakti Kendra") {
      context.read<ZilaDataCubit>().getDependentDropdownData(
          remainingURL:
              "data/required_locations?location_type=CountryState&location_id=14&required_location_type=ShaktiKendra&ac_id=$id",
          type: type);
    }
  }

  static mainDropdownName(String type) {
    print(type);
    if (type == "Pradesh") {
      return "Pradesh";
    } else if (type == "Zila" || type == "Mandal") {
      return "Zila";
    } else if (type == "Vibhag") {
      return "Vibhag";
    } else if (type == "Lok Sabha") {
      return "Lok Sabha";
    } else if (type == "Vidhan Sabha" ||
        type == "Shakti Kendra" ||
        type == "Booth") {
      return "Vidhan Sabha";
    }
  }

  static dependentDropdownName(String type) {
    if (type == "Mandal") {
      return "Mandal";
    } else if (type == "Booth") {
      return "Booth";
    } else if (type == "Shakti Kendra") {
      return "Shakti Kendra";
    }
  }
}
