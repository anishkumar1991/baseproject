import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/cubit/PollsCubit.dart';

import 'package:screenshot/screenshot.dart';
import '../BottomSocialBar.dart';
import '../cubit/FetchPostCubit.dart';

class Polls extends StatefulWidget {
  final screenshotController = ScreenshotController();

  final int tempindex;

  Polls({Key? key, required this.tempindex}) : super(key: key);

  @override
  State<Polls> createState() => _PollsState();
}

class _PollsState extends State<Polls> {
  var value1;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchPostsCubit>();
    final cubit1 = context.read<PollCubit>();
    return Material(
      elevation: 4,
      child: Screenshot(

        controller: widget.screenshotController,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 19),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cubit.tempModel!.posts[widget.tempindex].title.toString(),
                style: const TextStyle(
                    fontFamily: "Tw Cen MT",
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                cubit.tempModel!.posts[widget.tempindex].caption.toString(),
                style: const TextStyle(
                    fontFamily: "Tw Cen MT",
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Color(0xFF666666)),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemCount: cubit.tempModel!.posts[widget.tempindex].postData
                      .poll!.options.length,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: ((context, index) =>
                      const SizedBox(height: 8)),
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(30)),
                      child: RadioListTile(
                        title: Text(
                            cubit.tempModel!.posts[widget.tempindex].postData
                                .poll!.options[index].content
                                .toString(),
                            style: const TextStyle(
                                fontFamily: 'Tw Cen MT',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey)),
                        value: index,
                        groupValue: value1,
                        onChanged: (value) {
                          cubit1.submitPoll(
                              cubit.tempModel!.posts[widget.tempindex].postData
                                  .poll!.id,
                              cubit.tempModel!.posts[widget.tempindex].postData
                                  .poll!.options[index].id);
                          setState(() {
                            value1 = value!;
                          });
                        },
                      ),
                    );
                  })),
              BottomSocialBar(
                  index: widget.tempindex,
                  screenshotController: widget.screenshotController),
              const SizedBox(height: 10),
              // BottomSocialBar(),
            ],
          ),
        ),
      ),
    );
  }
}
