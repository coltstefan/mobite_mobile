import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/widgets/loading2.dart';
import 'package:delivery_app/src/widgets/title.dart';

import 'package:flutter/material.dart';

import '../helpers/style.dart';


class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Stack(
        children: [
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(

            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Positioned.fill(child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Positioned.fill(child: Align(
                            alignment: Alignment.center,
                            child: Loading2(),
                          )),
                          Image.network(category.image) 
                        ],
                      )
                  ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.025),
                  ],
                )
            ),
          ),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: CustomText(text: category.name, color: Colors.white, size: 26, weight: FontWeight.bold,)))
        ],
      ),
    );
  }
}
