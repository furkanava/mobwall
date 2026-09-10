<div align="center">

# Mobwall

### Kod ajanının içinde, daha iyi mobil paywall’lar.

Yeni abonelik ekranı tasarla. Mevcut ekranı incele. Uygulamana uygula.

**Claude Code · Codex · Cursor · Antigravity**

[![MIT · Açık kaynak](../assets/badges/license.svg)](../LICENSE)
[![Yerel kurulum · Hesap gerekmez](../assets/badges/install.svg)](installation.md)
[![Swift · Kotlin · Dart](../assets/badges/platforms.svg)](#platformlar-ve-diller)

[English](../README.md) · **Türkçe**

[Kurulum](#kurulum) · [Örnekler](#platformlar-ve-diller) · [Doğrulama](validation.md) · [Vaka kaydı](country-case-study.md)

</div>

![Kurmaca önce/sonra tasarım çalışması: karmaşık paywall, değer karşılaştırması ve plan seçimi olarak iki ekrana ayrılıyor.](../assets/preview-skill.png)

<p align="center"><sub>Bu görsel bir tasarım illüstrasyonudur; gerçek bir ajan çalışmasının ekran kaydı veya ölçülmüş dönüşüm sonucu değildir.</sub></p>

## Ne yapar?

| Girdi | Çıktı |
| :--- | :--- |
| Ekran görüntüsü | Görülebilen unsurlara dayalı analiz, önerilen metin ve yerleşim. |
| Ürün brief’i | Ücretli değeri ve satın alma koşullarını açıklayan tasarım. |
| Mevcut uygulama | Gerçek fiyatları, state management ve ödeme altyapısını koruyan arayüz değişiklikleri. |
| Test sorusu | Sınanabilir hipotez, anlamlı ölçüm ve uygulanabilir kontroller. |

**Skill, kod ajanının okuduğu talimat paketidir.** Bağımsız tasarım uygulaması veya ödeme SDK’sı değildir. Görsel üretimi, ajanın mevcut araçlarına bağlıdır. Gerçek ödeme ve erişim doğrulaması uygulamanın mevcut servisinde kalır.

## Kurulum

Repoyu indir veya klonla. Repo kökünde çalıştır:

```sh
python3 scripts/install.py --agent all --project "/uygulamanin/tam/yolu"
```

Tek araç için `all` yerine `cursor`, `claude`, `codex` veya `antigravity` kullan. Hedef uygulama klasörü mevcut olmalı. Kurucu Python 3.9+ ister; Windows’ta gerekirse `python` kullan.

| Araç | Projedeki konum | Kullanım |
| :--- | :--- | :--- |
| Claude Code | `.claude/skills/mobwall/` | `/mobwall` |
| Codex | `.agents/skills/mobwall/` | `$mobwall` |
| Cursor | `.agents/skills/mobwall/` | Agent sohbetinde `/` menüsünden seç |
| Antigravity | `.agents/skills/mobwall/` | `mobwall` skill’ini kullanmasını iste |

Kurulumdan sonra ajanı hedef projenin içinde yeniden başlat. Kurucu ağ bağlantısı kurmaz; mevcut farklı sürümlerin üzerine yazmaz. Dört istemcide kapsamlı uçtan uca kullanım bağımsız doğrulanmış değildir.

<details>
<summary><strong>Elle kurulum ve güncelleme</strong></summary>

[Skill klasörünün](../skills/mobwall) tamamını, `references/` dahil, yukarıdaki hedefe kopyala. Son yol `mobwall/SKILL.md` olmalı.

Güncellerken eski skill klasörünü keşif klasörlerinin dışındaki bir yedek konuma taşı, ardından yeni sürümü kur. Aynı skill’i hem `.cursor/skills` hem `.agents/skills` altında tutma.

[Ayrıntılı kurulum ve sorun giderme](installation.md)

Önceki `mobile-paywall` sürümünü kurduysan çift keşfi önlemek için [isim değişikliği adımlarını](installation.md#rename-migration) uygula.

</details>

## Dene

Ekran görüntünü ekleyip önce analiz iste:

```text
mobwall skill’ini kullanarak mevcut paywall’ımı incele.
İlgili skill referanslarını, ekranı ve kodu oku.
Gerçek ürünleri, fiyatları ve deneme uygunluğunu koru.
Önceliklendirilmiş bulgular ve somut tasarım önerisi ver. Şimdilik kod değiştirme.
```

Sonra uygulamayı iste:

```text
mobwall ile öneriyi mevcut uygulamamda uygula.
State management, navigation ve ödeme entegrasyonunu koru.
Var/yok özelliklerinde ✓/—, sayısal limitlerde metin kullan.
Ekran okuyucu açıklamalarını, geri yüklemeyi ve yenileme koşullarını koru.
İlgili kontrolleri çalıştır; doğrulanmayan noktaları belirt.
```

## Platformlar ve diller

| Platform | Kod dili | Örnek ve doğrulama |
| :--- | :--- | :--- |
| Flutter · iOS/Android hostları | Dart | [İki ekranlı demo](../examples/flutter/README.md): analiz, 8 widget testi; kayıtlı sürümlerde web derlemesi ve tarayıcı kontrolü. |
| Android · Jetpack Compose | Kotlin | [Native demo](../examples/android/README.md): debug APK derlendi. |
| iOS · SwiftUI | Swift | [Örnek ekran](../examples/swiftui/README.md): macOS tip kontrolü ve önizleme; yerelde iOS derlemesi yapılmadı. |
| React Native | JavaScript / TypeScript | [Entegrasyon rehberi](../skills/mobwall/references/implementation.md); hazır proje ve platform testi yok. |

**Dokümantasyon:** İngilizce ve Türkçe. **Demo arayüzleri:** İngilizce. Skill, ürünün istenen dilini ve mevcut yerelleştirme dosyalarını takip eder; tüm diller için hazır veya test edilmiş çeviri paketi sunmaz.

## Tasarım yaklaşımı

Kapsamlı onboarding çalışmasında **değer ve Ücretsiz/Plus karşılaştırması → teklif ve satın alma** adımlarını değerlendirir. Var/yok özelliklerinde ✓/—, gerçek limitlerde metin kullanır; ekran okuyucuya anlamlı açıklama verir.

Küçük değişikliği tam yeniden tasarıma dönüştürmez. Kullanıcı değeri zaten biliyorsa fazladan ekran zorunlu değildir. İki ekran ve karşılaştırma tablosu test edilecek tasarım seçenekleridir.

[İki ekranlı tasarım](../examples/cases/grove-two-step.md) · [Kaynaklar](../skills/mobwall/references/research.md)

## Bildirilen üretim kullanımı

Geliştirici, bu skill kullanılan Android uygulamasının Google Play Console’da yedi ülkeden uygulama içi satın alma aldığını bildirdi.

| ABD | Birleşik Krallık | Hindistan | Türkiye |
| :---: | :---: | :---: | :---: |
| ![ABD](../assets/flags/us.svg) | ![Birleşik Krallık](../assets/flags/gb.svg) | ![Hindistan](../assets/flags/in.svg) | ![Türkiye](../assets/flags/tr.svg) |

| Kazakistan | Finlandiya | Belçika |
| :---: | :---: | :---: |
| ![Kazakistan](../assets/flags/kz.svg) | ![Finlandiya](../assets/flags/fi.svg) | ![Belçika](../assets/flags/be.svg) |

[Vaka kaydı](country-case-study.md). Console kayıtları bu repo için bağımsız incelenmedi; bu bildirim dönüşüm artışını kanıtlamaz.

## Doğrulama ve lisans

**15 kurulum testi · 8 Flutter widget testi · 16 yazılmış değerlendirme senaryosu.** Senaryolar, bağımsız tamamlanmış 16 ajan çalışması değildir. Paylaşılan bir Cursor analiz çıktısı bulunur; bu kapsamlı uyumluluk testi sayılmaz.

[Sürüm ve test ayrıntıları](validation.md) · [Katkı rehberi](../CONTRIBUTING.md)

Özgün proje içeriği **[MIT lisanslıdır](../LICENSE)**; ticari kullanım da mümkündür. Hesap, lisans anahtarı, telemetri ve zorunlu harici bağlantı yoktur. AI sağlayıcısının kendi kullanım ücretleri olabilir. Demo ödeme işlemleri gerçekte para çekmez.

[Gradle](../examples/android/gradle/README.md), [Flutter](../examples/flutter/FLUTTER_LICENSE) ve [bayraklar](../assets/flags/README.md) kendi lisans bildirimlerini korur.
