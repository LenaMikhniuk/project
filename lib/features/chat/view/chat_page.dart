import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:this_is_project/widgets/colors/app_colors.dart';
import 'package:this_is_project/widgets/dimens/app_dimens.dart';
import 'package:this_is_project/translations/locale_keys.g.dart';

const _appId = 'b29024b093a14dcaaa186c017e5f1780';
const _tempToken =
    '007eJxTYHjIu8Pjt7jqIyGTnIsZcreV9IXXG4ef3FN4yzG0PrLp5gsFhiQjSwMjkyQDS+NEQ5OU5MTEREMLs2QDQ/NU0zRDcwuD9+vXJTcEMjLcYkxiZWSAQBCfhyE5IzEvLzUnLbOouISBAQAimiJr';
const _channelName = 'channelfirst';

const _containerHeight = 240.0;

class ChatPage extends StatefulWidget {
  static const path = 'chatPage';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int uid = 0;
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _isHost = true;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: _appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  @override
  dispose() async {
    await _engine.leaveChannel();
    super.dispose();
  }

  Future<void> join() async {
    ChannelMediaOptions options;

    if (_isHost) {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      await _engine.startPreview();
    } else {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
    }
    await _engine.joinChannel(
      token: _tempToken,
      channelId: _channelName,
      uid: uid,
      options: options,
    );
  }

  void leave() async {
    setState(() {
      _localUserJoined = false;
      _remoteUid = null;
    });
    _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _containerHeight,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: _videoPanel(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.l),
              child: Row(
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: _isHost,
                    onChanged: (value) => _handleRadioValueChange(value),
                  ),
                  Text(
                    LocaleKeys.host.tr().toUpperCase(),
                    style: const TextStyle(color: AppColors.prymaryTextColor),
                  ),
                  Radio<bool>(
                    value: false,
                    groupValue: _isHost,
                    onChanged: (value) => _handleRadioValueChange(value),
                  ),
                  Text(
                    LocaleKeys.audience.tr().toUpperCase(),
                    style: const TextStyle(color: AppColors.prymaryTextColor),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(LocaleKeys.joinButton.tr()),
                    onPressed: () => join(),
                  ),
                ),
                const SizedBox(width: AppDimens.sm),
                Expanded(
                  child: ElevatedButton(
                    child: Text(LocaleKeys.leaveButton.tr()),
                    onPressed: () => leave(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _videoPanel() {
    if (!_localUserJoined) {
      return Text(
        LocaleKeys.joinMe.tr(),
        style: const TextStyle(color: AppColors.prymaryTextColor),
      );
    } else if (_isHost) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: _engine,
          canvas: VideoCanvas(
            uid: uid,
          ),
        ),
      );
    } else {
      if (_remoteUid != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: const RtcConnection(channelId: _channelName),
          ),
        );
      } else {
        return Text(
          LocaleKeys.waitingHost.tr(),
          style: const TextStyle(color: AppColors.prymaryTextColor),
        );
      }
    }
  }

  void _handleRadioValueChange(bool? value) async {
    setState(() {
      _isHost = (value = true);
    });
    if (_localUserJoined) {
      leave();
    }
  }
}
