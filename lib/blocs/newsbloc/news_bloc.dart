import 'package:blocnews/blocs/newsbloc/news_events.dart';
import 'package:blocnews/blocs/newsbloc/news_states.dart';
import 'package:blocnews/models/article_model.dart';
import 'package:blocnews/repositories/news_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepository newsRepositoty;
  NewsBloc({@required NewsStates initialState, @required this.newsRepositoty})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsStates> mapEventToState(NewsEvents event) async* {
    if (event is StartEvent) {
      try {
        List<ArticleModel> _articleList = [];
        yield NewsLoadingState();
        _articleList = await newsRepositoty.fetchNews();
        yield NewsLoadedState(articleList: _articleList);
      } catch (e) {
        yield NewsErrorState(errorMessage: e);
      }
    }
  }
}

//bloc completed

// let's deploy this bloc in ui
