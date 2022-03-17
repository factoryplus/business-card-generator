import 'dart:math';

import 'package:business_card_generator/src/Data/Asset.dart';
import 'package:business_card_generator/src/structure/stack_type_general.dart';
import 'package:flutter/material.dart';

class TotalCards {
  String userName;
  String contactNumber;
  String ?email;
  String ?address;
  String industry;

  TotalCards(this.userName, this.contactNumber,this.address,this.email,this.industry);

  List<Widget> _totalCards = List.empty(growable: true);

  void _populateList() {
    _totalCards.clear();
    _totalCards = [
      StackTypeGeneral(
          Assets.FreePik41, GlobalKey(), userName, contactNumber,address,email,industry),
      StackTypeGeneral(
          Assets.card_background_two, GlobalKey(), userName, contactNumber,address,email,industry),
      StackTypeGeneral(
          Assets.card_background_third, GlobalKey(), userName, contactNumber,address,email,industry),
      StackTypeGeneral(
          Assets.card_background_one, GlobalKey(), userName, contactNumber,address,email,industry),
      StackTypeGeneral(
          Assets.card_background_third, GlobalKey(), userName, contactNumber,address,email,industry),
      StackTypeGeneral(
          Assets.card_background_two, GlobalKey(), userName, contactNumber,address,email,industry),
    ];
  }

  List<Widget> getTotalCards() {
    _populateList();
    return _totalCards;
  }

  List<Widget> fetchMoreData(int index) {
    List<Widget> _tempList = List.empty(growable: true);
    int _finalIndex = min(index + 2, _totalCards.length);
    if (index < _totalCards.length) {
      for (int i = index; i < _finalIndex ; i++) {
        _tempList.add(_totalCards[i]);
      }
    }
    return _tempList;
  }

  List<Widget> getInitialData() {
    _populateList();
    List<Widget> _tempList = List.empty(growable: true);
    int _finalIndex = min(5, _totalCards.length);
    for (int i = 0; i < _finalIndex; i++) {
      _tempList.add(_totalCards[i]);
    }
    return _tempList;
  }
}


