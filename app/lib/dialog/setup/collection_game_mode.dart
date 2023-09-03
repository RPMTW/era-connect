import 'dart:async';

import 'package:era_connect/api/lib.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class CollectionGameModeStep extends StatefulWidget {
  final GameMode initialGameMode;
  final VersionMetadata? initialVersion;

  const CollectionGameModeStep(
      {super.key, required this.initialGameMode, this.initialVersion});

  @override
  State<CollectionGameModeStep> createState() => _CollectionGameModeStepState();
}

class _CollectionGameModeStepState extends State<CollectionGameModeStep> {
  final Completer<List<VersionMetadata>> _versions = Completer();

  @override
  void initState() {
    super.initState();
    _versions.complete(metaApi.getVanillaVersions());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '遊戲方式',
          style: TextStyle(
            color: context.theme.textColor,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '選擇您想建立的收藏遊戲模式',
          style:
              TextStyle(color: context.theme.tertiaryTextColor, fontSize: 15),
        ),
        const SizedBox(height: 25),
        Expanded(
          child: FutureBuilder(
              future: _versions.future,
              builder: (context, snapshot) {
                final data = snapshot.data;

                return DialogRectangleTab(
                  title: '遊戲方式',
                  initialPage: widget.initialGameMode.index,
                  tabs: [
                    _buildTab('原汁原味', '在 Era Connect 裡體驗最經典的 Minecraft 世界！',
                        EraIcon.assets('clear_day'), GameMode.vanilla, data),
                    _buildTab(
                        '搶先體驗',
                        '搶先體驗到測試中的快照版 Minecraft',
                        EraIcon.material(Icons.local_fire_department_outlined),
                        GameMode.snapshot,
                        data),
                    TabItem(
                      title: '創意模組',
                      icon: EraIcon.material(Icons.draw_outlined),
                      content: const DialogContentBox(
                        title: '介紹',
                        content: SizedBox.shrink(),
                      ),
                      onTap: () =>
                          const GameModeNotification(gameMode: GameMode.modded)
                              .dispatch(context),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

  TabItem _buildTab(String title, String description, EraIcon icon,
      GameMode gameMode, List<VersionMetadata>? versions) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/${gameMode.name}.png', fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.theme.deepBackgroundColor.withOpacity(0.1),
                  context.theme.deepBackgroundColor.withOpacity(0.7)
                ],
              ),
            ),
          ),
          Center(
            child: IconTheme(
              data: const IconThemeData(size: 80),
              child: icon,
            ),
          ),
        ],
      ),
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: context.theme.textColor,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: context.theme.secondaryTextColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        EraField(
          title: '遊戲版本',
          tooltip: '選擇您想要的遊玩的 Minecraft 版本',
          child: Builder(builder: (context) {
            if (versions == null) {
              return EraDropdownMenu(
                items: [
                  EraDropdownMenuItem(
                    icon: EraIcon.material(Icons.hourglass_empty_rounded),
                    label: const Text('載入中...'),
                  ),
                ],
              );
            }

            final versionType = gameMode == GameMode.snapshot
                ? VersionType.Snapshot
                : VersionType.Release;
            final filteredVersions =
                versions.where((e) => e.versionType == versionType).toList();

            return _GameVersionPicker(
                versions: filteredVersions,
                initialVersion: widget.initialVersion);
          }),
        )
      ],
    );

    return TabItem(
      title: title,
      icon: icon,
      content: DialogContentBox(
        title: '介紹',
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: image,
            ),
            const SizedBox(width: 20),
            Flexible(
              flex: 3,
              child: content,
            )
          ],
        ),
      ),
      onTap: () => GameModeNotification(gameMode: gameMode).dispatch(context),
    );
  }
}

class _GameVersionPicker extends StatefulWidget {
  final List<VersionMetadata> versions;
  final VersionMetadata? initialVersion;

  const _GameVersionPicker({required this.versions, this.initialVersion});

  @override
  State<_GameVersionPicker> createState() => _GameVersionPickerState();
}

class _GameVersionPickerState extends State<_GameVersionPicker> {
  late VersionMetadata _selectedVersion;

  @override
  void initState() {
    final latestVersion = widget.versions.first;
    _selectedVersion = widget.initialVersion ?? latestVersion;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool shouldDispatch = widget.initialVersion == null ||
          !widget.versions.contains(widget.initialVersion);
      if (shouldDispatch) {
        GameModeNotification(version: latestVersion).dispatch(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final initialIndex = widget.versions.indexOf(_selectedVersion);

    return EraDropdownMenu(
        items: _generateItems(),
        initialIndex: initialIndex == -1 ? 0 : initialIndex);
  }

  List<EraDropdownMenuItem> _generateItems() {
    final items = <EraDropdownMenuItem>[];

    final latestVersion = widget.versions.first;
    items.add(EraDropdownMenuItem(
      icon: EraIcon.assets('new_releases', color: context.theme.accentColor),
      label: Text.rich(
        TextSpan(
          text: '最新版本',
          children: [
            TextSpan(
              text: '（${latestVersion.id}）',
              style: TextStyle(color: context.theme.tertiaryTextColor),
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _selectedVersion = latestVersion;
        });
        GameModeNotification(version: latestVersion).dispatch(context);
      },
    ));

    widget.versions.skip(1).forEach((e) {
      items.add(EraDropdownMenuItem(
        icon: EraIcon.material(Icons.fast_forward_rounded),
        label: Text(e.id),
        onTap: () {
          setState(() {
            _selectedVersion = e;
          });
          GameModeNotification(version: e).dispatch(context);
        },
      ));
    });

    return items;
  }
}

enum GameMode {
  vanilla,
  snapshot,
  modded,
}

class GameModeNotification extends Notification {
  final GameMode? gameMode;
  final VersionMetadata? version;

  const GameModeNotification({this.gameMode, this.version});
}
