import 'package:flutter/material.dart';
import 'package:hiddify/core/model/constants.dart';
import 'package:hiddify/features/nil_catcher/nil_catcher_feed.dart';
import 'package:hiddify/features/profile/model/profile_entity.dart';
import 'package:hiddify/features/profile/notifier/active_profile_notifier.dart';
import 'package:hiddify/features/profile/notifier/profile_notifier.dart';
import 'package:hiddify/features/proxy/active/active_proxy_notifier.dart';
import 'package:hiddify/features/proxy/model/proxy_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NilCatcherCard extends ConsumerWidget {
  const NilCatcherCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(activeProfileProvider).valueOrNull;
    final selected = active is RemoteProfileEntity && active.url == nilCatcherFeed.toString();
    final busy = ref.watch(addProfileNotifierProvider).isLoading;
    final health = selected ? ref.watch(connectionHealthProvider) : null;
    final fastest = health?.fastest;
    final delay = fastest?.urlTestDelay ?? 0;
    final hasMeasurement = ConnectionConst.isValidDelay(delay);
    final group = health?.mainGroup;
    final autoSelected = health?.pickTag == lowestGroupTag;
    final fa = Localizations.localeOf(context).languageCode == 'fa';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.cloud_download_outlined),
        title: const Text('Nil Config Catcher'),
        subtitle: Text(
          hasMeasurement
              ? (fa ? 'کمترین زمان پاسخ: ${fastest!.tag} · ${delay} ms' : 'Lowest delay: ${fastest!.tag} · ${delay} ms')
              : (fa ? 'دریافت اشتراک و به‌روزرسانی هر دو ساعت' : 'Import the feed and refresh every two hours'),
        ),
        trailing: busy
            ? const SizedBox.square(dimension: 24, child: CircularProgressIndicator(strokeWidth: 2))
            : !selected
            ? TextButton(
                onPressed: ref.read(addProfileNotifierProvider.notifier).useNilCatcher,
                child: Text(fa ? 'استفاده از اشتراک' : 'Use feed'),
              )
            : group != null && !autoSelected
            ? TextButton(
                onPressed: () => ref.read(activeProxyNotifierProvider.notifier).switchToLowest(group),
                child: Text(fa ? 'انتخاب خودکار' : 'Auto-select'),
              )
            : null,
      ),
    );
  }
}
