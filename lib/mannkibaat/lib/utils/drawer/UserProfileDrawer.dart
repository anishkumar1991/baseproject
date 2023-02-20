import 'package:flutter/material.dart';
import '../../values/AppColors.dart';

class UserProfileDrawer extends StatelessWidget {
  const UserProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 56),
        child: Drawer(
          elevation: 200,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10)),
            ),
            backgroundColor: Colors.white,
            // backgroundColor: AppColor().backgroundColor,
            child: ListView(
              children: [
                Container(
                  height: 109,
                  width: 246  ,
                  decoration: const BoxDecoration(color: Color(0xA3EBF2FF)),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 19),
                    child: Row(

                      children: const [
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('packages/mannkibaatpackage/lib/assets/drawer_temp.png'),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              width: 200,
                              child: ListTile(
                                title: Text("Ram Prasad Yadav"),
                                subtitle: Text("9988776655"),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 22.5),
                ListTile(
                  iconColor: Colors.white,
                  leading: Icon(
                    Icons.home,
                    color: AppColor().reviewFormTextColor,
                  ),
                  title: Text('Sewa Hi Sangathan',
                      style: TextStyle(color: AppColor().drawertextcolor)),
                  onTap: () {
                    // Add Navigation logic here
                  },
                ),
                const Divider(indent: 19, endIndent: 16, thickness: 1),

                ListTile(
                  iconColor: Colors.white,
                  leading: Icon(
                    Icons.account_circle,
                    color: AppColor().reviewFormTextColor,
                  ),
                  title: Text('Profile',
                      style: TextStyle(color: AppColor().drawertextcolor)),
                  onTap: () {
                    // Add Navigation logic here
                  },
                ),
                const Divider(indent: 19, endIndent: 16, thickness: 1),

                ListTile(
                  iconColor: Colors.white,
                  leading: Icon(
                    Icons.logout_sharp,
                    color: AppColor().reviewFormTextColor,
                  ),
                  title: Text('Logout',
                      style: TextStyle(color: AppColor().drawertextcolor)),
                  onTap: () {
                    // Add Navigation logic here
                  },
                ),
                const Divider(indent: 19, endIndent: 16, thickness: 1),
              ],
            )),
      ),
    );
  }
}
