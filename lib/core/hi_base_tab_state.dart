import 'package:flutter/material.dart';
import 'package:hongyanasst/core/hi_state.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/widgets/toast.dart';

abstract class HiBaseTabState<M, L, T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pageIndex = 1;
  bool loading = false;
  ScrollController scrollController = ScrollController();

  get contentChild;

  // life cycle: initialize page state
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      print('dis:$dis');
      if (dis < 300 &&
          !loading &&
          scrollController.position.maxScrollExtent != 0) {
        print('------_loadData---');
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  // life cycle: dispose page, including listeners and controllers
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  // life cycle: build widgets on the page
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: loadData,
      color: ColorHelper.primary,
      child: MediaQuery.removePadding(
          removeTop: true, context: context, child: contentChild),
    );
  }

  // common method: get page data via http apis
  Future<M> getData(int pageIndex);

  // common method: parse list
  List<L> parseList(M result);

  // common method: bottom refresh
  Future<void> loadData({loadMore = false}) async {
    if (loading) {
      return;
    }
    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print('loading:currentIndex:$currentIndex');
    try {
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      print(e);
      ShowToast.showToast(e.message, context);
    } on HiNetError catch (e) {
      loading = false;
      print(e);
      ShowToast.showToast(e.message, context);
    }
  }

  // keep page alive to prevent from duplicate load
  @override
  bool get wantKeepAlive => true;
}
