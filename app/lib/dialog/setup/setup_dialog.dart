import 'package:era_connect/api/lib.dart';
import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

import 'import_profiles.dart';
import 'login_account.dart';
import 'collection_game_mode.dart';
import 'collection_information.dart';
import 'collection_addition.dart';

class SetupDialog extends StatefulWidget {
  const SetupDialog({super.key});

  @override
  State<SetupDialog> createState() => _SetupDialogState();
}

class _SetupDialogState extends State<SetupDialog> {
  GameMode _gameMode = GameMode.vanilla;
  VersionMetadata? _version;
  String? _displayName;

  @override
  Widget build(BuildContext context) {
    return StepDialog(
      steps: [
        StepData(
          stepDescription: '匯入或新建設定',
          title: context.i18n['dialog.setup.welcome'],
          description: context.i18n['dialog.setup.01.description'],
          hasBrandText: true,
          contentPages: const [ImportProfilesStep()],
        ),
        StepData(
            stepDescription: '登入帳號',
            title: context.i18n['dialog.setup.welcome'],
            description: context.i18n['dialog.setup.01.description'],
            contentPages: const [LoginAccountStep()],
            onEvent: (event, _) {
              final hasAnyAccount =
                  storageApi.accountStorage.accounts.isNotEmpty;
              if (event == StepEvent.next && !hasAnyAccount) {
                showEraDialog(
                    context: context,
                    dialog: EraAlertDialog(
                      title: '提醒',
                      description: '請您至少要先登入一個帳號才可繼續下個步驟。',
                      actions: [
                        EraPrimaryButton.icon(
                          icon: EraIcon.material(Icons.close_rounded),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ));
                return false;
              }

              return true;
            }),
        StepData(
          stepDescription: '建立第一個收藏',
          title: context.i18n['dialog.setup.welcome'],
          description: context.i18n['dialog.setup.01.description'],
          contentPages: [
            NotificationListener<GameModeNotification>(
              onNotification: (notification) {
                if (notification.gameMode != null) {
                  _gameMode = notification.gameMode!;
                }

                if (notification.version != null) {
                  _version = notification.version!;
                }

                return true;
              },
              child: CollectionGameModeStep(
                  initialGameMode: _gameMode, initialVersion: _version),
            ),
            if (_gameMode == GameMode.modded)
              const Text('choose mod loader and loader version'),
            NotificationListener<InformationNotification>(
              onNotification: (notification) {
                final information = notification.information;
                if (information.displayName != null) {
                  _displayName = information.displayName!;
                }

                return true;
              },
              child: CollectionInformationStep(
                initialInformation:
                    CollectionInformation(displayName: _displayName),
                gameMode: _gameMode,
              ),
            )
          ],
          onEvent: (event, contentPageIndex) {
            if (event == StepEvent.previous || event == StepEvent.next) {
              setState(() {});
            }
            if (event != StepEvent.next) return true;

            final bool hasChosenVersion = _version != null;
            if (contentPageIndex == 0 && !hasChosenVersion) {
              return false;
            }

            return true;
          },
        ),
        StepData(
          stepDescription: '為您的收藏加入內容',
          title: context.i18n['dialog.setup.welcome'],
          description: context.i18n['dialog.setup.01.description'],
          contentPages: [const CollectionAdditionStep()],
          onEvent: (event, _) {
            if (event == StepEvent.previous) {
              setState(() {});
            }

            return true;
          },
        ),
        StepData(
          stepDescription: '大功告成！',
          title: '大功告成！',
          description: '恭喜你完成了所有設定並建立了第一個收藏，現在就開始在豐富多元的 Minecraft 世界中盡情探索吧！',
          contentPages: [const SizedBox.shrink()],
          onEvent: (event, _) {
            if (event == StepEvent.done) {
              storageApi.uiLayout.completedSetup = true;
            }

            return true;
          },
        )
      ],
    );
  }
}
