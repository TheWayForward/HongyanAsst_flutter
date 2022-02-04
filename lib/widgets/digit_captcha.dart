import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/dao/phone_captcha_dao.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/message_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/utils/verification_helper.dart';
import 'package:hongyanasst/widgets/common_input.dart';
import 'package:hongyanasst/widgets/large_button.dart';
import 'package:hongyanasst/widgets/loading_mask.dart';
import 'package:hongyanasst/widgets/toast.dart';

class DigitCaptcha extends StatefulWidget {
  final int countdown;
  final bool enabled;
  final int maxLength;
  final String tel;
  final ValueChanged<String> onChanged;

  const DigitCaptcha(
      {Key? key,
        required this.maxLength,
      required this.countdown,
        required this.onChanged,
        required this.tel,
      this.enabled = false})
      : super(key: key);

  @override
  _DigitCaptchaState createState() => _DigitCaptchaState();
}

class _DigitCaptchaState extends State<DigitCaptcha> {
  Timer? _timer;
  int _seconds = 60;
  double _fontSize = 16;
  String _content = TagHelper.send_ch;
  bool _canSend = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _seconds = widget.countdown;
      _content = TagHelper.send_ch;
      _canSend = _canSend;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 3,
            child: Container(
              child: CommonInput(
                  inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
                  enabled: widget.enabled,
                  hint: TagHelper.captcha_ch,
                  helperText: TagHelper.captcha_helper_text_ch,
                  onChanged: widget.onChanged,
                  focusChanged: (bool focus) {},
                  keyboardType: TextInputType.number),
            )),
        SizedBox(width: 10),
        Flexible(
            flex: 1,
            child: Container(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                height: 45,
                onPressed: _canSend ? _sendCaptcha : null,
                disabledColor: ColorHelper.primary[50],
                color: ColorHelper.primary,
                child: Text(_content,
                    style: TextStyle(color: Colors.white, fontSize: _fontSize)),
              ),
            ))
      ],
    );
  }

  _sendCaptcha() async {
    if (!VerificationHelper.telVerification(widget.tel)) {
      ShowToast.showToast(MessageHelper.tel_illegal_ch);
      return;
    }
    LoadingMask.showLoading(MessageHelper.loading_indication_ch);
    if (_canSend) {
      try {
        var result = await PhoneCaptchaDao.get(widget.tel);
        print(result);
        LoadingMask.dismiss();
        ShowToast.showToast(MessageHelper.captcha_sent_ch);
      } on NeedAuth catch (e) {
        LoadingMask.dismiss();
        LoadingMask.showInfo(MessageHelper.request_unauth_ch);
      } on HiNetError catch (e) {
        LoadingMask.dismiss();
        LoadingMask.showError(MessageHelper.internal_error_ch);
      }
    }
    _canSend = false;
    _fontSize = 12;
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (_seconds == 1) {
        // 1 cycle finished
        _cancelTimer();
        setState(() {
          _content = TagHelper.send_ch;
          _canSend = true;
          _fontSize = 16;
        });
        _seconds = widget.countdown;
        return;
      }
      setState(() {
        _seconds--;
        _content = "${TagHelper.resend_ch}(${_seconds}s)";
      });
    });
  }

  _cancelTimer() {
    _timer!.cancel();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
