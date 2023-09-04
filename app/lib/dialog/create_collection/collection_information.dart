import 'package:blur/blur.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

import 'collection_game_mode.dart';

class CollectionInformationStep extends StatefulWidget {
  final CollectionInformation initialInformation;
  final GameMode gameMode;
  final void Function(String? displayName)? onNotification;

  const CollectionInformationStep(
      {super.key,
      required this.initialInformation,
      required this.gameMode,
      this.onNotification});

  @override
  State<CollectionInformationStep> createState() =>
      _CollectionInformationStepState();
}

class _CollectionInformationStepState extends State<CollectionInformationStep> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<InformationNotification>(
      onNotification: (notification) {
        widget.onNotification?.call(notification.information.displayName);

        return true;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '收藏設定',
            style: TextStyle(
              color: context.theme.textColor,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '設定這個收藏的詳細資訊',
            style:
                TextStyle(color: context.theme.tertiaryTextColor, fontSize: 15),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: DialogContentBox(
              title: '收藏資訊',
              content: Column(
                children: [
                  Expanded(child: _buildMainContent()),
                  const SizedBox(height: 15),
                  _buildAdvancedOptionButton()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/collection_background.png',
              fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  context.theme.deepBackgroundColor.withOpacity(0.5),
                  context.theme.deepBackgroundColor.withOpacity(0.8),
                  context.theme.deepBackgroundColor,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Builder(builder: (context) {
              return _buildOverlay(context);
            }),
          )
        ],
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StyleArea(gameMode: widget.gameMode),
        const Spacer(),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraField(
                title: '收藏名稱',
                child: EraTextField(
                  hintText: '新的收藏',
                  initialValue: widget.initialInformation.displayName,
                  onChanged: (value) {
                    InformationNotification(
                            CollectionInformation(displayName: value))
                        .dispatch(context);
                  },
                ),
              ),
              EraField(
                title: '分類',
                child: EraDropdownMenu(
                  items: [
                    EraDropdownMenuItem(
                      icon: EraIcon.material(Icons.bookmarks_rounded,
                          color: context.theme.accentColor),
                      label: const Text('預設'),
                    ),
                  ],
                  backgroundColor: context.theme.backgroundColor,
                ),
              ),
              EraField(
                title: '光影載入器',
                tooltip:
                    '光影載入器是一種用於載入光影（Shader）的模組，常見的載入器有 OptiFine 與 Iris。\n\n部分遊戲版本或遊戲方式不支援使用光影載入器',
                child: EraDropdownMenu(
                  items: [
                    EraDropdownMenuItem(
                      icon: EraIcon.assets('motion_mode',
                          color: context.theme.tertiaryTextColor),
                      label: const Text('無'),
                    ),
                  ],
                  backgroundColor: context.theme.backgroundColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAdvancedOptionButton() {
    return EraBasicButton(
      onPressed: () {},
      style: EraBasicButtonStyle(
          backgroundColor: context.theme.deepBackgroundColor,
          hoverColor: Colors.transparent,
          borderRadius: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                EraIcon.material(Icons.settings_applications_rounded),
                const SizedBox(width: 15),
                Text(
                  '進階選項',
                  style:
                      TextStyle(fontSize: 16, color: context.theme.textColor),
                ),
              ],
            ),
            EraIcon.material(Icons.density_large_rounded,
                color: context.theme.tertiaryTextColor),
          ],
        ),
      ),
    );
  }
}

class _StyleArea extends StatefulWidget {
  final GameMode gameMode;
  const _StyleArea({required this.gameMode});

  @override
  State<_StyleArea> createState() => _StyleAreaState();
}

class _StyleAreaState extends State<_StyleArea> {
  bool _buttonIsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/${widget.gameMode.name}.png'),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 4),
              )
            ],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          right: 0,
          bottom: 20,
          width: _buttonIsExpanded ? 130 : 50,
          height: 50,
          child: _buildButton(),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _buttonIsExpanded = true;
        });
      },
      onExit: (_) {
        setState(() {
          _buttonIsExpanded = false;
        });
      },
      child: Blur(
        blur: 30,
        colorOpacity: 0,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
        overlay: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            EraIcon.material(Icons.format_paint_rounded),
            if (_buttonIsExpanded) ...[
              const SizedBox(width: 7),
              const Flexible(
                  child: Text('風格化修改', overflow: TextOverflow.ellipsis)),
            ]
          ],
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/vanilla.png'),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InformationNotification extends Notification {
  final CollectionInformation information;

  const InformationNotification(this.information);
}

class CollectionInformation {
  final String? displayName;
  final String? coverPath;
  final String? backgroundPath;

  const CollectionInformation(
      {this.displayName, this.coverPath, this.backgroundPath});
}
