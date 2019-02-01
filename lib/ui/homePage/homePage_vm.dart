import '../../models/card.dart';
import '../../models/appState.dart';
import 'package:redux/redux.dart';
import '../../utils/appType.dart';
import '../../redux/actions.dart';

class ViewModel {
  final List<CardModel> cards;

  final Function(AppType) getCardsByType;

  final Function() refreshCards;

  ViewModel({this.cards, this.getCardsByType, this.refreshCards});

  factory ViewModel.create(Store<AppState> store) {

    _getCardsByType(AppType type){
      store.dispatch(CardsByType(type: type));
    }

    _refreshCards(){
      store.dispatch(GetCards());
    }

    return ViewModel(cards: store.state.cards, getCardsByType: _getCardsByType, refreshCards: 
      _refreshCards);
  }
}