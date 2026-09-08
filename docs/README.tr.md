# Mobile Paywall

Mobil uygulamalarda abonelik ekranı tasarlayan veya mevcut paywall'ı iyileştiren, ücretsiz ve MIT lisanslı açık kaynak skill.

**Claude Code, Codex, Cursor ve Antigravity** için ortak talimatlar içerir. Araca özel kurulum yolları resmi belgelerle kontrol edilmiştir; dört istemcide uçtan uca kullanım henüz doğrulanmamıştır.

## Kurulum

Repoyu indirip klasöründe şu komutu çalıştır:

```sh
python3 scripts/install.py --agent all --project "/uygulamanin/tam/yolu"
```

Python 3.9+ gerekir; Windows'ta `python` kullanabilirsin. [Elle kurulum](installation.md) için Python gerekmez. Kurulum mevcut farklı skill dosyalarının üzerine yazmaz.

Uygulama projesinde ajanına şunu söyle:

```text
mobile-paywall skill'ini kullanarak mevcut paywall'ımı iyileştir.
Önce ekranı ve uygulamanın tasarım dilini incele.
Mevcut fiyatları ve satın alma altyapısını koruyarak tasarımı uygula.
Neyi test ettiğini ve doğrulanamayan noktaları belirt.
```

Yalnızca analiz istiyorsan bunu açıkça belirt; skill bu durumda kodu değiştirmez. Ekran görüntüsünden başlayabilir veya sıfırdan ürün brief'i verebilirsin.

## Referans araştırması ve iki ekranlı tasarım

Skill artık kapsamlı onboarding tasarımlarında önce kaynakları inceleyip tabloda karşılaştırır; ardından **değer/Ücretsiz–Plus karşılaştırması → planlar ve satın alma** şeklinde iki ekranlı bir aday sunar. Tek ekranlı kontrolü ve istisnaların gerekçesini belirtir. [Örnek akış](../examples/cases/grove-two-step.md) tasarım belirtimidir; mevcut native demolar hâlâ tek ekranlı kontroldür.

[Mobbin MCP isteğe bağlıdır](mobbin.md) ve kendi ücretli planına tabidir. [Araştırma kaydı](../skills/mobile-paywall/references/research.md), video zaman damgalarını, kütüphane sayısıyla deney örneklemi arasındaki farkı ve araştırmaların sınırlarını açıklar.

[Bayraklı ülke vaka şablonu](country-case-study.md): 🇺🇸 🇬🇧 🇮🇳 🇹🇷 🇰🇿 🇫🇮 🇧🇪. Uygulama ve gerçek satın alma verileri henüz sağlanmadığı için doğrulanmış başarı iddiası olarak sunulmaz.

## İçerik

- Sıfırdan tasarım, mevcut ekran analizi ve projede uygulama akışı.
- Fiyat/deneme açıklığı, görsel hiyerarşi, erişilebilirlik ve hata durumları.
- SwiftUI, Kotlin/Jetpack Compose, Flutter ve React Native için uygulama rehberi.
- Gerçek ödeme yapmayan [SwiftUI örnek ekranı](../examples/swiftui/README.md) ve [Android Compose demo projesi](../examples/android/README.md).
- Üç kurmaca ürün senaryosu, davranış değerlendirmeleri ve kurulum testleri.

Skill ücretsizdir; kullandığın AI aracının kendi kullanım ücretleri olabilir. Zorunlu ücretli servis, hesap, telemetri veya lisans anahtarı yoktur. Ölçülmemiş dönüşüm artışı ve mağaza onayı vaat etmez.

[Ana sayfa](../README.md) · [Doğrulama durumu](validation.md) · [MIT lisansı](../LICENSE)
