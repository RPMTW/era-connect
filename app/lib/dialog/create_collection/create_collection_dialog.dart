import 'package:era_connect/api/lib.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/widgets.dart';

import 'collection_game_mode.dart';
import 'collection_information.dart';

class CreateCollectionDialog extends StatefulWidget {
  const CreateCollectionDialog({super.key});

  @override
  State<CreateCollectionDialog> createState() => _CreateCollectionDialogState();
}

class _CreateCollectionDialogState extends State<CreateCollectionDialog> {
  GameMode _gameMode = GameMode.vanilla;
  VersionMetadata? _version;
  String? _displayName;

  @override
  Widget build(BuildContext context) {
    return StepDialog(
      steps: [
        StepData(
          stepDescription: '遊戲方式',
          title: '建立收藏',
          description: '建立一個全新的收藏',
          hasBrandText: true,
          logoBoxText: 'Create',
          contentPages: [
            CollectionGameModeStep(
              initialGameMode: _gameMode,
              initialVersion: _version,
              onNotification: (gameMode, version) {
                if (gameMode != null) {
                  _gameMode = gameMode;
                }

                if (version != null) {
                  _version = version;
                }
              },
            ),
          ],
          onEvent: (event, _) {
            _updateState(event);
            if (event == StepEvent.next && _version == null) {
              return false;
            }

            return true;
          },
        ),
        if (_gameMode == GameMode.modded)
          StepData(
            stepDescription: '模組載入器',
            title: '建立收藏',
            description: '建立一個全新的收藏',
            logoBoxText: 'Create',
            contentPages: [
              const Text('choose mod loader and loader version'),
            ],
            onEvent: (event, _) {
              _updateState(event);
              return true;
            },
          ),
        StepData(
          stepDescription: '收藏設定',
          title: '建立收藏',
          description: '建立一個全新的收藏',
          logoBoxText: 'Create',
          contentPages: [
            CollectionInformationStep(
              initialInformation:
                  CollectionInformation(displayName: _displayName),
              gameMode: _gameMode,
              onNotification: (displayName) {
                if (displayName != null) {
                  _displayName = displayName;
                }
              },
            )
          ],
          onEvent: (event, _) {
            _updateState(event);
            return true;
          },
        ),
        StepData(
          stepDescription: '完成建立',
          title: '完成建立',
          description: '你完成了所有建立步驟，確定要以此設定建立收藏嗎？',
          logoBoxText: 'Create',
          contentPages: [const SizedBox.shrink()],
          onEvent: (event, _) {
            if (event == StepEvent.done && _version != null) {
              print('done');
              collectionApi.create(
                displayName: _displayName ?? '新的收藏',
                versionMetadata: _version!,
              );
            }

            return true;
          },
        )
      ],
    );
  }

  void _updateState(StepEvent event) {
    if (event == StepEvent.next) {
      setState(() {});
    }
  }
}
