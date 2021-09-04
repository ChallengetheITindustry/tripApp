import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/view_model/main_model.dart';

// ignore: must_be_immutable
class FormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<MainModel>(
      create: (context) => MainModel(),
      child: Consumer<MainModel>(builder: (context, model, child) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                      child: DotsIndicator(
                        dotsCount: model.pageLength,
                        position: model.currentPage,
                        decorator: DotsDecorator(
                          activeColor: Colors.white,
                          activeSize: const Size(15.0, 15.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PageView.builder(
                itemCount: model.pages.length,
                controller: model.controller,
                onPageChanged: (int index) async {
                  model.ChangePage(index);
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      model.pages[index],
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 15,
                      )
                    ],
                  );
                }),
          ],
        );
      }),
    );
  }
}
