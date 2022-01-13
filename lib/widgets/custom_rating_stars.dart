import 'package:flutter/material.dart';

class CustomRatingStars extends StatelessWidget {
  const CustomRatingStars({required this.rating, Key? key}) : super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    return (rating == 0)
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _empty(),
              _empty(),
              _empty(),
              _empty(),
              _empty(),
            ],
          )
        : (rating > 0 && rating < 1)
            ? Row(
                children: <Widget>[
                  _half(context),
                  _empty(),
                  _empty(),
                  _empty(),
                  _empty(),
                ],
              )
            : (rating == 1)
                ? Row(
                    children: <Widget>[
                      _fill(context),
                      _empty(),
                      _empty(),
                      _empty(),
                      _empty(),
                    ],
                  )
                : (rating > 1 && rating < 2)
                    ? Row(
                        children: <Widget>[
                          _fill(context),
                          _half(context),
                          _empty(),
                          _empty(),
                          _empty(),
                        ],
                      )
                    : (rating == 2)
                        ? Row(
                            children: <Widget>[
                              _fill(context),
                              _fill(context),
                              _empty(),
                              _empty(),
                              _empty(),
                            ],
                          )
                        : (rating > 2 && rating < 3)
                            ? Row(
                                children: <Widget>[
                                  _fill(context),
                                  _fill(context),
                                  _half(context),
                                  _empty(),
                                  _empty(),
                                ],
                              )
                            : (rating == 3)
                                ? Row(
                                    children: <Widget>[
                                      _fill(context),
                                      _fill(context),
                                      _fill(context),
                                      _empty(),
                                      _empty(),
                                    ],
                                  )
                                : (rating > 3 && rating < 4)
                                    ? Row(
                                        children: <Widget>[
                                          _fill(context),
                                          _fill(context),
                                          _fill(context),
                                          _half(context),
                                          _empty(),
                                        ],
                                      )
                                    : (rating == 4)
                                        ? Row(
                                            children: <Widget>[
                                              _fill(context),
                                              _fill(context),
                                              _fill(context),
                                              _fill(context),
                                              _empty(),
                                            ],
                                          )
                                        : (rating > 4 && rating < 5)
                                            ? Row(
                                                children: <Widget>[
                                                  _fill(context),
                                                  _fill(context),
                                                  _fill(context),
                                                  _fill(context),
                                                  _half(context),
                                                ],
                                              )
                                            : Row(
                                                children: <Widget>[
                                                  _fill(context),
                                                  _fill(context),
                                                  _fill(context),
                                                  _fill(context),
                                                  _fill(context),
                                                ],
                                              );
  }

  Icon _empty() =>
      const Icon(Icons.star_border_rounded, color: Colors.grey, size: 16);
  Icon _fill(BuildContext context) => Icon(Icons.star_rate_rounded,
      color: Theme.of(context).primaryColor, size: 16);
  Icon _half(BuildContext context) => Icon(Icons.star_half_rounded,
      color: Theme.of(context).primaryColor, size: 16);
}
