# نصب آزمایشی NIL Proxy روی آیفون با کابل

این شاخه از کلاینت بومی `nil-native` ادامه پیدا کرده و فید زندهٔ NIL و موتور Packet Tunnel را دارد. برای نصب مستقیم، مک و Xcode سازگار با نسخهٔ iOS، Flutter 3.38.5، CocoaPods و یک Team فعال Apple Developer Program لازم است. برای iOS 27.2، Xcode 27.2 انتخاب هم‌نسخه است.

۱. دریافت سورس و آماده‌سازی Workspace روی مک

```bash
git clone --branch nil/ios-usb --single-branch https://github.com/babakyaghoobii/Nil-proxy.git
cd Nil-proxy
make CHANNEL=prod ios-prepare SHELL=/bin/bash '.SHELLFLAGS=-eo pipefail -c'
open ios/Runner.xcworkspace
```

۲. در **Signing & Capabilities**، برای هر دو Target یعنی **Runner** و **HiddifyPacketTunnel**، گزینهٔ **Automatically manage signing** و یک Team مشترک را انتخاب کنید. تنظیمات نصب کابلی مربوط به **Debug** است.

| مورد | شناسه |
| --- | --- |
| Runner | `io.github.babakyaghoobii.nilproxy` |
| HiddifyPacketTunnel | `io.github.babakyaghoobii.nilproxy.HiddifyPacketTunnel` |
| App Group مشترک | `group.io.github.babakyaghoobii.nilproxy` |

پروفایل‌های توسعه باید مجوزهای پروژه برای **Packet Tunnel**، **Personal VPN** و **App Groups** را داشته باشند. اگر Xcode گروه مشترک را ثبت نکرد، همان شناسهٔ جدول را در Team ثبت و روی هر دو Target انتخاب کنید.

۳. آیفون را با کابل وصل کنید. بعد از Pair و Trust، **Developer Mode** را در تنظیمات آیفون فعال کنید. در Xcode با Scheme **Runner** خود آیفون را انتخاب کنید و **Run** را بزنید. داخل اپ از کارت **Nil Config Catcher** اشتراک را انتخاب کنید، سپس از **Connect** و تأیید مجوز VPN در iOS استفاده کنید.

معیار تست دستگاه، وضعیت اتصال iOS و عبور ترافیک از تونل با یک کانفیگ پاسخ‌گو است. Build بدون امضا فقط وجود اپ و افزونه و صحت بسته‌بندی را بررسی می‌کند.

- [سازگاری Xcode و iOS](https://developer.apple.com/xcode/system-requirements/)
- [تنظیم Network Extension](https://developer.apple.com/documentation/xcode/configuring-network-extensions/)
