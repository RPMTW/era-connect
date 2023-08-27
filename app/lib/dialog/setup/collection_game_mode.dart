import 'package:era_connect/api/lib.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class CollectionGameMode extends StatelessWidget {
  final ValueChanged<GameMode> onGameModeChanged;

  const CollectionGameMode({super.key, required this.onGameModeChanged});

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
          child: DialogRectangleTab(
            title: '遊戲方式',
            tabs: [
              _buildTab(context, '原汁原味', '在 Era Connect 裡體驗最經典的 Minecraft 世界！',
                  EraIcon.assets('clear_day'), GameMode.vanilla),
              _buildTab(
                  context,
                  '搶先體驗',
                  '搶先體驗到測試中的快照版 Minecraft',
                  EraIcon.material(Icons.local_fire_department_outlined),
                  GameMode.snapshot),
              TabItem(
                title: '創意模組',
                icon: EraIcon.material(Icons.draw_outlined),
                content: const DialogContentBox(
                  title: '介紹',
                  content: SizedBox.shrink(),
                ),
                onTap: () => onGameModeChanged(GameMode.modded),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TabItem _buildTab(BuildContext context, String title, String description,
      EraIcon icon, GameMode gameMode) {
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
        const SizedBox(height: 20),
        Text(
          '遊戲版本',
          style: TextStyle(fontSize: 16, color: context.theme.textColor),
        ),
        const SizedBox(height: 5),
        FutureBuilder(
            future: metaApi.getVanillaVersions(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final versionType = gameMode == GameMode.snapshot
                  ? VersionType.Snapshot
                  : VersionType.Release;
              final versions = snapshot.data!
                  .where((e) => e.versionType == versionType)
                  .toList();

              return _GameVersionPicker(versions: versions);
            }),
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
    );
  }
}

class _GameVersionPicker extends StatefulWidget {
  final List<BasicVersionMetadata> versions;
  const _GameVersionPicker({required this.versions});

  @override
  State<_GameVersionPicker> createState() => _GameVersionPickerState();
}

class _GameVersionPickerState extends State<_GameVersionPicker> {
  late BasicVersionMetadata _selectedVersion;
  final List<EraDropdownMenuItem> _items = [];

  @override
  void initState() {
    _generateItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EraDropdownMenu(
        items: _items, initialIndex: widget.versions.indexOf(_selectedVersion));
  }

  void _generateItems() {
    final latestVersion = widget.versions.first;
    _selectedVersion = latestVersion;

    _items.add(EraDropdownMenuItem(
      icon: EraIcon.assets('new_releases', color: context.theme.accentColor),
      label: Text.rich(
        TextSpan(
          text: '最新版本',
          children: [
            TextSpan(
                text: '（${latestVersion.id}）',
                style: TextStyle(color: context.theme.tertiaryTextColor))
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _selectedVersion = latestVersion;
        });
      },
    ));

    widget.versions.skip(1).forEach((e) {
      _items.add(EraDropdownMenuItem(
        icon: EraIcon.material(Icons.fast_forward_rounded),
        label: Text(e.id),
        onTap: () {
          setState(() {
            _selectedVersion = e;
          });
        },
      ));
    });
  }
}

enum GameMode {
  modded,
  snapshot,
  vanilla,
}
