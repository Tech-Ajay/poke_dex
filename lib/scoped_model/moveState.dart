

import 'package:poke_poke_dex/helper/enum.dart';
import 'package:poke_poke_dex/model/MovesList.dart';

import '../helper/constants.dart';
import 'appState.dart';

class MoveState extends AppState{
   late List<Result> _movesList;
   List<Result> get movesList {
     if(_movesList == null){
       return [];
     }
     else{
       return List.from(_movesList);
     }
   }
   late HomePageButtonEnum _pageType;
   late String _nextUrl ;
  Future<void> getMovesList(HomePageButtonEnum pageType,{bool initialLoad = true})async{
      try{
          apiCall(isReady: true,);
          if(initialLoad){
            _nextUrl = '';
          }
          if(!initialLoad && _nextUrl == null){
            print('All items fetched');
            return;
          }
          var url = _nextUrl != null ? _nextUrl : getUrl(pageType) ;
          var response = await getAsync(url);
          if (response != null) {
            if(response.statusCode != 200){
              print('API Status code error' + response.body);
            }
            print('Api call success');
            var  _pokemonMoves = movesResponseFromJson(response.body);
            if(_pokemonMoves != null){
              if(_movesList != null ){
                print('Next Moves added');
                _movesList.addAll( _pokemonMoves.results);
              }
              else{
                _movesList = _pokemonMoves.results;
              }
              _nextUrl = _pokemonMoves.next;
              apiCall(isReady: false,isnotify: true);
            }
          } else {
           apiCall(isReady: false,isnotify: true);
         }
    }
    catch(error){
      apiCall(isReady: false,isnotify: true,isApiError: true);
      print('ERROR [getMovesList]: $error');
    }
  }
 String getUrl(HomePageButtonEnum pageType){
   _movesList = [];
   switch (pageType) {
     case HomePageButtonEnum.Abilitie : return 'https://pokeapi.co/api/v2/ability?limit=120&offset=50';       
     case HomePageButtonEnum.Item : return 'https://pokeapi.co/api/v2/item?limit=120&offset=50';       
     case HomePageButtonEnum.Berries : return 'https://pokeapi.co/api/v2/berry?limit=120&offset=1';      
     case HomePageButtonEnum.Move : return 'https://pokeapi.co/api/v2/move?limit=120&offset=50';       
     case HomePageButtonEnum.Pokemon : return 'https://pokeapi.co/api/v2/move?limit=120&offset=50';       
     case HomePageButtonEnum.Habitats : return 'https://pokeapi.co/api/v2/pokemon-habitat';
     default:
     return '';
   }
 }
}