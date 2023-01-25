import 'package:flutter/material.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';

class EventListView extends StatelessWidget {
  const EventListView(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap,
      required this.date});
  final String title;
  final String subtitle;
  final String date;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Image.asset(
                      AppIcons.listView,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColor.brown200,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    width: 216,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'Tw Cen MT',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            subtitle,
                            style: const TextStyle(
                                fontFamily: 'Tw Cen MT',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColor.greyColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                                fontFamily: 'Tw Cen MT',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColor.brownColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: AppColor.brownColor),
                              onPressed: onTap,
                              icon: const Icon(
                                Icons.schedule,
                                color: AppColor.white,
                              ),
                              label: const Text(
                                'Upcoming',
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
