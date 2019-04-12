/**
 * https://github.com/BakerJQ/Flutter-InfiniteCards
 */

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  InfiniteCardsController _controller;
  bool _isTypeSwitch = true;

  @override
  void initState() {
    super.initState();
    _controller = InfiniteCardsController(
      itemBuilder: _renderItem,
      itemCount: 5,
      animType: AnimType.SWITCH,
    );
  }

  Widget _renderItem(BuildContext context, int index) {
    return Image(
      image: AssetImage('images/pic${index + 1}.png'),
    );
  }

  void _changeType(BuildContext context) {
    if (_isTypeSwitch) {
      _controller.reset(
        itemCount: 4,
        animType: AnimType.TO_FRONT,
        transformToBack: _customToBackTransform,
      );
    } else {
      _controller.reset(
        itemCount: 5,
        animType: AnimType.SWITCH,
        transformToBack: DefaultToBackTransform,
      );
    }
    _isTypeSwitch = !_isTypeSwitch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InfiniteCards"),
      ),
      body: Column(
        children: <Widget>[
          InfiniteCards(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 1.3,
            controller: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _controller.reset(
                      animType:
                          _isTypeSwitch ? AnimType.SWITCH : AnimType.TO_FRONT);
                  _controller.previous();
                },
                child: Text("Pre"),
              ),
              RaisedButton(
                onPressed: () {
                  _changeType(context);
                },
                child: Text("Reset"),
              ),
              RaisedButton(
                onPressed: () {
                  _controller.reset(animType: AnimType.TO_END);
                  _controller.next();
                },
                child: Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Transform _customToBackTransform(
    Widget item,
    double fraction,
    double curveFraction,
    double cardHeight,
    double cardWidth,
    int fromPosition,
    int toPosition) {
  int positionCount = fromPosition - toPosition;
  double scale = (0.8 - 0.1 * fromPosition) + (0.1 * fraction * positionCount);
  double rotateY;
  double translationX;
  if (fraction < 0.5) {
    translationX = cardWidth * fraction * 1.5;
    rotateY = math.pi / 2 * fraction;
  } else {
    translationX = cardWidth * 1.5 * (1 - fraction);
    rotateY = math.pi / 2 * (1 - fraction);
  }
  double interpolatorScale =
      0.8 - 0.1 * fromPosition + (0.1 * curveFraction * positionCount);
  double translationY = -cardHeight * (0.8 - interpolatorScale) * 0.5 -
      cardHeight * (0.02 * fromPosition - 0.02 * curveFraction * positionCount);
  return Transform.translate(
    offset: Offset(translationX, translationY),
    child: Transform.scale(
      scale: scale,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(rotateY),
        alignment: Alignment.center,
        child: item,
      ),
    ),
  );
}

class InfiniteCardsController {
  //widget item builder
  IndexedWidgetBuilder _itemBuilder;

  //item count
  int _itemCount;

  //switch anim duration
  Duration _animDuration;

  //true: switch animation while click on item, false: item not clickable
  bool _clickItemToSwitch;

  //anim transforms
  AnimTransform _transformToFront,
      _transformToBack,
      _transformCommon,
      _transformAdd,
      _transformRemove;

  //zIndex transforms
  ZIndexTransform _zIndexTransformCommon,
      _zIndexTransformToFront,
      _zIndexTransformToBack;

  //animation type
  AnimType _animType;

  //curve
  Curve _curve;

  //helper
  AnimHelper _animHelper;

  InfiniteCardsController({
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
    Duration animDuration,
    bool clickItemToSwitch = true,
    AnimTransform transformToFront = DefaultToFrontTransform,
    AnimTransform transformToBack = DefaultToBackTransform,
    AnimTransform transformCommon = DefaultCommonTransform,
    AnimTransform transformAdd = DefaultAddTransform,
    AnimTransform transformRemove = DefaultRemoveTransform,
    ZIndexTransform zIndexTransformCommon = DefaultCommonZIndexTransform,
    ZIndexTransform zIndexTransformToFront = DefaultToFrontZIndexTransform,
    ZIndexTransform zIndexTransformToBack = DefaultCommonZIndexTransform,
    AnimType animType = AnimType.TO_FRONT,
    Curve curve = DefaultCurve,
  })  : _itemBuilder = itemBuilder,
        _itemCount = itemCount,
        _animDuration = animDuration,
        _clickItemToSwitch = clickItemToSwitch,
        _transformToFront = transformToFront,
        _transformToBack = transformToBack,
        _transformCommon = transformCommon,
        _transformAdd = transformAdd,
        _transformRemove = transformRemove,
        _zIndexTransformCommon = zIndexTransformCommon,
        _zIndexTransformToFront = zIndexTransformToFront,
        _zIndexTransformToBack = zIndexTransformToBack,
        _animType = animType,
        _curve = curve;

  void previous() {
    _animHelper.previous();
  }

  void next() {
    _animHelper.next();
  }

  void anim(int index) {
    _animHelper.anim(index);
  }

  //reset params
  void reset({
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
    Duration animDuration,
    bool clickItemToSwitch,
    AnimTransform transformToFront,
    AnimTransform transformToBack,
    AnimTransform transformCommon,
    AnimTransform transformAdd,
    AnimTransform transformRemove,
    ZIndexTransform zIndexTransformCommon,
    ZIndexTransform zIndexTransformToFront,
    ZIndexTransform zIndexTransformToBack,
    AnimType animType,
    Curve curve,
    bool forceReset = false,
  }) {
    if (_animHelper.isAnim()) {
      return;
    }
    //if item is changed, force reset
    if (itemBuilder != null || itemCount != null) {
      forceReset = true;
    }
    //reset params while remove anim comes to an end
    _animHelper.animCallback = (AnimStatus status) {
      if (status == AnimStatus.RemoveEnd) {
        this._itemBuilder = itemBuilder ?? this._itemBuilder;
        this._itemCount = itemCount ?? this._itemCount;
        this._animDuration = animDuration ?? this._animDuration;
        this._clickItemToSwitch = clickItemToSwitch ?? this._clickItemToSwitch;
        this._transformToFront = transformToFront ?? this._transformToFront;
        this._transformToBack = transformToBack ?? this._transformToBack;
        this._transformCommon = transformCommon ?? this._transformCommon;
        this._transformAdd = transformAdd ?? this._transformAdd;
        this._transformRemove = transformRemove ?? this._transformRemove;
        this._zIndexTransformCommon =
            zIndexTransformCommon ?? this._zIndexTransformCommon;
        this._zIndexTransformToFront =
            zIndexTransformToFront ?? this._zIndexTransformToFront;
        this._zIndexTransformToBack =
            zIndexTransformToBack ?? this._zIndexTransformToBack;
        this._animType = animType ?? this._animType;
        this._curve = curve ?? this._curve;
        if (forceReset) {
          _animHelper.resetWidgets();
        }
        _animHelper.animCallback = null;
      }
    };
    if (forceReset) {
      _animHelper.reset();
      return;
    }
    //direct set params
    _animHelper.animCallback(AnimStatus.RemoveEnd);
  }

  Curve get curve => _curve;

  AnimType get animType => _animType;

  get zIndexTransformToBack => _zIndexTransformToBack;

  get zIndexTransformToFront => _zIndexTransformToFront;

  ZIndexTransform get zIndexTransformCommon => _zIndexTransformCommon;

  get transformRemove => _transformRemove;

  get transformAdd => _transformAdd;

  get transformCommon => _transformCommon;

  get transformToBack => _transformToBack;

  AnimTransform get transformToFront => _transformToFront;

  bool get clickItemToSwitch => _clickItemToSwitch;

  Duration get animDuration => _animDuration;

  int get itemCount => _itemCount;

  IndexedWidgetBuilder get itemBuilder => _itemBuilder;

  set animHelper(AnimHelper value) {
    _animHelper = value;
  }
}

typedef AnimTransform = Transform Function(
    Widget item,
    double fraction,
    double curveFraction,
    double cardHeight,
    double cardWidth,
    int fromPosition,
    int toPosition);

typedef ZIndexTransform = void Function(
    CardItem card,
    double fraction,
    double curveFraction,
    double cardWidth,
    double cardHeight,
    int fromPosition,
    int toPosition);

const AnimTransform DefaultCommonTransform = _defaultCommonTransform,
    DefaultAddTransform = _defaultAddTransform,
    DefaultRemoveTransform = _defaultRemoveTransform,
    DefaultToBackTransform = _defaultToBackTransform,
    DefaultToFrontTransform = _defaultToFrontTransform;

const ZIndexTransform DefaultCommonZIndexTransform =
        _defaultCommonZIndexTransform,
    DefaultToFrontZIndexTransform = _defaultToFrontZIndexTransform;

const Curve DefaultCurve = _DefaultCurve();

Transform _defaultCommonTransform(
    Widget item,
    double fraction,
    double curveFraction,
    double cardHeight,
    double cardWidth,
    int fromPosition,
    int toPosition) {
  int positionCount = fromPosition - toPosition;
  double scale = (0.8 - 0.1 * fromPosition) + (0.1 * fraction * positionCount);
  double translationY = -cardHeight * (0.8 - scale) * 0.5 -
      cardHeight * (0.02 * fromPosition - 0.02 * fraction * positionCount);
  return Transform.translate(
    offset: Offset(0, translationY),
    child: Transform.scale(
      scale: scale,
      child: item,
    ),
  );
}

Transform _defaultAddTransform(
    Widget item,
    double fraction,
    double curveFraction,
    double cardHeight,
    double cardWidth,
    int fromPosition,
    int toPosition) {
  int positionCount = fromPosition - toPosition;
  double scale = (0.8 - 0.1 * fromPosition) + (0.1 * fraction * positionCount);
  double translationY = -cardHeight * (0.8 - scale) * 0.5 -
      cardHeight * (0.02 * fromPosition - 0.02 * fraction * positionCount);
  double opacity = fraction;
  return Transform.translate(
    offset: Offset(0, translationY),
    child: Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: item,
      ),
    ),
  );
}

Transform _defaultRemoveTransform(
    Widget item,
    double fraction,
    double curveFraction,
    double cardHeight,
    double cardWidth,
    int fromPosition,
    int toPosition) {
  double scale = (0.8 - 0.1 * fromPosition);
  double translationY = -cardHeight * (0.8 - scale) * 0.5 -
      cardHeight * 0.02 * fromPosition +
      cardHeight * fraction;
  double opacity = 1 - fraction;
  return Transform.translate(
    offset: Offset(0, translationY),
    child: Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: item,
      ),
    ),
  );
}

Transform _defaultToBackTransform(
    Widget item,
    double fraction,
    double curveFraction,
    double cardHeight,
    double cardWidth,
    int fromPosition,
    int toPosition) {
  int positionCount = fromPosition - toPosition;
  double scale = (0.8 - 0.1 * fromPosition) + (0.1 * fraction * positionCount);
  double rotateX;
  if (fraction < 0.5) {
    rotateX = -math.pi * fraction;
  } else {
    rotateX = -math.pi * (1 - fraction);
  }
  double interpolatorScale =
      0.8 - 0.1 * fromPosition + (0.1 * curveFraction * positionCount);
  double translationY = -cardHeight * (0.8 - interpolatorScale) * 0.5 -
      cardHeight * (0.02 * fromPosition - 0.02 * curveFraction * positionCount);
  return Transform.translate(
    offset: Offset(0, translationY),
    child: Transform.scale(
      scale: scale,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateX(rotateX),
        alignment: Alignment.center,
        child: item,
      ),
    ),
  );
}

Transform _defaultToFrontTransform(
    Widget item,
    double fraction,
    double curveFraction,
    double cardHeight,
    double cardWidth,
    int fromPosition,
    int toPosition) {
  int positionCount = fromPosition - toPosition;
  double scale = (0.8 - 0.1 * fromPosition) + (0.1 * fraction * positionCount);
  double rotateX = -math.pi * (1 - fraction);
  double translationY;
  if (fraction < 0.5) {
    translationY = -cardHeight * (0.8 - scale) * 0.5 -
        cardHeight * 0.02 * fromPosition -
        cardHeight * fraction;
  } else {
    translationY = -cardHeight * (0.8 - scale) * 0.5 -
        cardHeight * (0.02 * fromPosition - 0.02 * fraction * positionCount) -
        cardHeight * (1 - fraction);
  }
  return Transform.translate(
    offset: Offset(0, translationY),
    child: Transform.scale(
      scale: scale,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateX(rotateX),
        alignment: Alignment.center,
        child: item,
      ),
    ),
  );
}

void _defaultCommonZIndexTransform(
    CardItem card,
    double fraction,
    double curveFraction,
    double cardWidth,
    double cardHeight,
    int fromPosition,
    int toPosition) {
  card.zIndex =
      1 + 0.01 * fromPosition + 0.01 * (toPosition - fromPosition) * fraction;
}

void _defaultToFrontZIndexTransform(
    CardItem card,
    double fraction,
    double curveFraction,
    double cardWidth,
    double cardHeight,
    int fromPosition,
    int toPosition) {
  if (fraction < 0.5) {
    card.zIndex = 1 + 0.01 * fromPosition;
  } else {
    card.zIndex = 1 + 0.01 * toPosition;
  }
}

class _DefaultCurve extends Curve {
  const _DefaultCurve();

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((-18 + 1) * t + -18) + 1.0;
  }
}

class CardItem {
  double zIndex;
  final int adapterIndex;
  final Widget widget;
  Widget transformWidget;

  CardItem(this.zIndex, this.adapterIndex, this.widget);

  @override
  int get hashCode => adapterIndex;

  @override
  bool operator ==(other) {
    if (!(other is CardItem)) {
      return false;
    }
    return other.adapterIndex == adapterIndex;
  }
}

enum AnimStatus { CardStart, CardEnd, AddStart, AddEnd, RemoveStart, RemoveEnd }

typedef AnimCallback = void Function(AnimStatus status);

const int ANIM_DURATION = 1000,
    ANIM_ADD_REMOVE_DELAY = 200,
    ANIM_ADD_REMOVE_DURATION = 500;

class AnimHelper {
  final InfiniteCardsController controller;
  final VoidCallback listenerForSetState;

  //animations for switch
  AnimationController _animationController;
  Animation<double> _animation;
  AnimCallback animCallback;

  //animations for add and remove
  List<AnimationController> _animationControllerAddRemoveList = new List();
  List<Animation<double>> _animationAddRemoveList = new List();

  //items
  List<CardItem> _cardList = new List();

  //item moves to back, item moves to front
  CardItem _cardToBack, _cardToFront;

  //the position of item moves to back, the position of item moves to front
  int _positionToBack, _positionToFront;

  //is add remove anim running, is switch anim running
  bool _isAddRemoveAnim = false, _isSwitchAnim = false, _isAddAnim = true;
  TickerProvider _tickerProvider;
  BuildContext _context;

  AnimHelper({@required this.controller, @required this.listenerForSetState});

  void init(TickerProvider tickerProvider, BuildContext context) {
    _tickerProvider = tickerProvider;
    _context = context;
    _initAnimation();
    _initCards();
  }

  //reset cards
  void reset() {
    if (isAnim()) {
      return;
    }
    _removeCards();
  }

  //reset card widgets
  void resetWidgets() {
    _initAddRemoveAnimation();
    _initWidgets();
  }

  //switch to previous card
  void previous() {
    if (isAnim()) {
      return;
    }
    //not support for TO_END type
    if (controller.animType == AnimType.TO_END) {
      return;
    }
    _cardAnim(controller.itemCount - 1, _cardList[controller.itemCount - 1]);
  }

  //switch to next card
  void next() {
    if (isAnim()) {
      return;
    }
    //only support for TO_END type
    if (controller.animType != AnimType.TO_END) {
      return;
    }
    _cardAnim(0, _cardList[0]);
  }

  //select specific index card
  void anim(int index) {
    if (isAnim()) {
      return;
    }
    if (controller.animType == AnimType.TO_END) {
      return;
    }
    _cardAnim(index, _cardList[index]);
  }

  //is animation running
  bool isAnim() {
    return _isSwitchAnim || _isAddRemoveAnim;
  }

  // get card widgets
  List<Widget> getCardList(double width, double height) {
    for (int i = 0; i < controller.itemCount; i++) {
      if (_isAddRemoveAnim) {
        //perform add remove anim
        if (_isAddAnim) {
          _addTransform(i, width, height);
        } else {
          _removeTransform(i, width, height);
        }
      } else if (_isSwitchAnim) {
        //perform switch anim
        _switchTransform(width, height, i);
      } else {
        //perform common anim
        _commonTransform(width, height, i, i);
      }
    }
    //render card widgets in the order of zIndex
    List<CardItem> copy = List.from(_cardList);
    copy.sort((card1, card2) {
      return card1.zIndex < card2.zIndex ? 1 : -1;
    });
    return copy.map((card) {
      return card.transformWidget;
    }).toList();
  }

  //init cards
  void _initCards() {
    _initWidgets();
    _addCards();
  }

  //init widgets
  void _initWidgets() {
    _cardList = List();
    for (int i = 0; i < controller.itemCount; i++) {
      Widget item = controller.itemBuilder(_context, i);
      item = _wrapItem(item, i);
      _cardList.add(CardItem(0, i, item));
    }
  }

  //add cards
  void _addCards() {
    _isAddAnim = true;
    if (animCallback != null) {
      animCallback(AnimStatus.AddStart);
    }
    _addRemoveAnim();
  }

  //remove cards
  void _removeCards() {
    _isAddAnim = false;
    if (animCallback != null) {
      animCallback(AnimStatus.RemoveStart);
    }
    _addRemoveAnim();
  }

  //add remove animation
  void _addRemoveAnim() {
    _isAddRemoveAnim = true;
    _isSwitchAnim = false;
    for (int i = 0; i < controller.itemCount; i++) {
      Future.delayed(Duration(milliseconds: ANIM_ADD_REMOVE_DELAY * i), () {
        _animationControllerAddRemoveList[i].forward(from: 0.0);
      });
    }
  }

  //init add remove animation
  void _initAddRemoveAnimation() {
    _animationControllerAddRemoveList = new List();
    _animationAddRemoveList = new List();
    for (int i = 0; i < controller.itemCount; i++) {
      AnimationController animationController = AnimationController(
          vsync: _tickerProvider,
          duration: const Duration(milliseconds: ANIM_ADD_REMOVE_DURATION));
      Animation<double> animation =
          new Tween(begin: 0.0, end: 1.0).animate(animationController);
      animation.addListener(listenerForSetState);
      animation.addStatusListener((status) {
        if (status == AnimationStatus.forward ||
            status == AnimationStatus.reverse) {
          _isAddRemoveAnim = true;
        }
      });
      if (i == controller.itemCount - 1) {
        animation.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _isAddRemoveAnim = false;
            _addRemoveAnimEnd();
          }
        });
      }
      _animationControllerAddRemoveList.add(animationController);
      _animationAddRemoveList.add(animation);
    }
  }

  //add remove animation end
  void _addRemoveAnimEnd() {
    for (AnimationController controller in _animationControllerAddRemoveList) {
      controller.reset();
    }
    if (animCallback != null) {
      animCallback(_isAddAnim ? AnimStatus.AddEnd : AnimStatus.RemoveEnd);
    }
    //if remove animation is end, start add card animation
    if (!_isAddAnim) {
      _cardList.sort((card1, card2) {
        return card1.adapterIndex > card2.adapterIndex ? 1 : -1;
      });
      _isAddRemoveAnim = true;
      _addCards();
    }
  }

  //animation for specific card
  void _cardAnim(int index, CardItem card) {
    if (isAnim()) {
      return;
    }
    if (animCallback != null) {
      animCallback(AnimStatus.CardStart);
    }
    switch (controller.animType) {
      /**
     * for SWITCH type, make the selected card to front, and make the first
     * card to the selected position
     */
      case AnimType.SWITCH:
        _cardToFront = card;
        _cardToBack = _cardList[0];
        _positionToBack = 0;
        _positionToFront = index;
        break;
      //for TO_FRONT type, just make the select card to first
      case AnimType.TO_FRONT:
        _cardToFront = card;
        _positionToFront = index;
        _cardToBack = null;
        _positionToBack = 0;
        break;
      //for TO_END type, just make the first to end
      case AnimType.TO_END:
        _cardToFront = null;
        _positionToFront = controller.itemCount - 1;
        _cardToBack = card;
        _positionToBack = index;
        break;
    }
    _animationController.forward(from: 0.0);
  }

  //init animation
  void _initAnimation() {
    _animationController = AnimationController(
        vsync: _tickerProvider,
        duration: controller.animDuration ??
            const Duration(milliseconds: ANIM_DURATION));
    _animation = new Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animation.addListener(listenerForSetState);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.forward ||
          status == AnimationStatus.reverse) {
        _isSwitchAnim = true;
      } else if (status == AnimationStatus.completed) {
        _animEnd();
        _isSwitchAnim = false;
      }
    });
    _initAddRemoveAnimation();
  }

  //wrap item with GestureDetector if clickItemToSwitch is true
  Widget _wrapItem(Widget item, int index) {
    Widget card = Center(
      child: item,
    );
    //type TO_END not support for switch anim
    if (controller.clickItemToSwitch &&
        controller.animType != AnimType.TO_END) {
      return GestureDetector(
        onTap: () {
          _onItemTap(index);
        },
        child: card,
      );
    }
    return card;
  }

  //tap to switch
  void _onItemTap(int index) {
    //type TO_END is not support
    if (controller.animType == AnimType.TO_END) {
      return;
    }
    for (int i = 0; i < controller.itemCount; i++) {
      CardItem card = _cardList[i];
      if (card.adapterIndex == index) {
        if (i != 0) {
          _cardAnim(i, card);
        }
        return;
      }
    }
  }

  //switch animation end
  void _animEnd() {
    switch (controller.animType) {
      // for SWITCH type, switch the position of the selected card and the first
      case AnimType.SWITCH:
        _cardList.removeAt(_positionToFront);
        _cardList.removeAt(0);
        _cardList.insert(0, _cardToFront);
        _cardList.insert(_positionToFront, _cardToBack);
        break;
      // for TO_FRONT type, move the selected card to first
      case AnimType.TO_FRONT:
        _cardList.removeAt(_positionToFront);
        _cardList.insert(0, _cardToFront);
        break;
      // for TO_END type, move the first card to end
      case AnimType.TO_END:
        _cardList.removeAt(0);
        _cardList.add(_cardToBack);
        break;
    }
    if (animCallback != null) {
      animCallback(AnimStatus.CardEnd);
    }
  }

  // remove anim transform
  void _removeTransform(int position, double width, double height) {
    CardItem cardItem = _cardList[position];
    Animation animation = _animationAddRemoveList[position];
    controller.zIndexTransformCommon(_cardList[position], animation.value,
        _getCurveValue(animation.value), width, height, position, position);
    cardItem.transformWidget = controller.transformRemove(
        cardItem.widget,
        animation.value,
        _getCurveValue(animation.value),
        width,
        height,
        position,
        position);
  }

  //common transform
  void _commonTransform(
      double width, double height, int fromPosition, int toPosition) {
    CardItem cardItem = _cardList[fromPosition];
    controller.zIndexTransformCommon(
        cardItem,
        _animation.value,
        _getCurveValue(_animation.value),
        width,
        height,
        fromPosition,
        toPosition);
    cardItem.transformWidget = controller.transformCommon(
        cardItem.widget,
        _animation.value,
        _getCurveValue(_animation.value),
        width,
        height,
        fromPosition,
        toPosition);
  }

  //switch transform
  void _switchTransform(double width, double height, int position) {
    CardItem cardItem = _cardList[position];
    if (cardItem == _cardToBack) {
      _toBackTransform(width, height, position, _positionToFront);
      return;
    } else if (cardItem == _cardToFront) {
      _toFrontTransform(width, height, position, _positionToBack);
      return;
    }
    switch (controller.animType) {
      case AnimType.SWITCH:
        break;
      case AnimType.TO_FRONT:
        if (position < _positionToFront) {
          _commonTransform(width, height, position, position + 1);
        }
        break;
      case AnimType.TO_END:
        if (position > _positionToBack) {
          _commonTransform(width, height, position, position - 1);
        }
        break;
    }
  }

  //add anim transform
  void _addTransform(int position, double width, double height) {
    CardItem cardItem = _cardList[position];
    Animation animation = _animationAddRemoveList[position];
    controller.zIndexTransformCommon(_cardList[position], animation.value,
        _getCurveValue(animation.value), width, height, position + 1, position);
    cardItem.transformWidget = controller.transformAdd(
        cardItem.widget,
        animation.value,
        _getCurveValue(animation.value),
        width,
        height,
        position + 1,
        position);
  }

  //to front transform
  void _toFrontTransform(
      double width, double height, int fromPosition, int toPosition) {
    CardItem cardItem = _cardList[fromPosition];
    controller.zIndexTransformToFront(
        cardItem,
        _animation.value,
        _getCurveValue(_animation.value),
        width,
        height,
        fromPosition,
        toPosition);
    cardItem.transformWidget = controller.transformToFront(
        cardItem.widget,
        _animation.value,
        _getCurveValue(_animation.value),
        width,
        height,
        fromPosition,
        toPosition);
  }

  //to back transform
  void _toBackTransform(
      double width, double height, int fromPosition, int toPosition) {
    CardItem cardItem = _cardList[fromPosition];
    controller.zIndexTransformToBack(
        cardItem,
        _animation.value,
        _getCurveValue(_animation.value),
        width,
        height,
        fromPosition,
        toPosition);
    cardItem.transformWidget = controller.transformToBack(
        cardItem.widget,
        _animation.value,
        _getCurveValue(_animation.value),
        width,
        height,
        fromPosition,
        toPosition);
  }

  //get value transformed by curve
  double _getCurveValue(double fraction) {
    return controller.curve == null
        ? fraction
        : controller.curve.transform(fraction);
  }
}

//Three types of animation
enum AnimType {
  TO_FRONT, //custom animation for chosen card, common animation for other cards
  SWITCH, //witch the position by custom animation of the first card and the chosen card
  TO_END, //moving the first card to last position by custom animation, common animation for others
}

class InfiniteCards extends StatefulWidget {
  final double width, height;
  final Color background;
  final InfiniteCardsController controller;

  InfiniteCards({
    @required this.controller,
    this.width,
    this.height,
    this.background,
  });

  @override
  _InfiniteCardsState createState() => _InfiniteCardsState();
}

class _InfiniteCardsState extends State<InfiniteCards>
    with TickerProviderStateMixin {
  double _width, _height;
  Color _background;
  AnimHelper _helper;

  @override
  void initState() {
    super.initState();
    //init background, helper, controller
    _background = widget.background ?? Color(0xffffffff);
    _helper = AnimHelper(
        controller: widget.controller,
        listenerForSetState: () {
          setState(() {});
        });
    _helper.init(this, context);
    if (widget.controller != null) {
      widget.controller.animHelper = _helper;
    }
  }

  @override
  Widget build(BuildContext context) {
    _width = widget.width ?? MediaQuery.of(context).size.width;
    _height = widget.height ?? MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      color: _background,
      child: Stack(
        children: _helper.getCardList(_width, _height),
      ),
    );
  }
}
