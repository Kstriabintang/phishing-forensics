# Deep Technical Analysis

Case `2026-08-18_kuota-gratis-81gb-hutri81` · lanjutan dari `../README.md`.

---

## 1. Rantai Penuh — 6 Hop

```
[0] Pesan WhatsApp (diteruskan korban lain)
        │
[1] LANDING   kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98
        │     • fake FB-post + loader "cek nomor" + bukti sosial palsu (626cdn.com)
        │     • GERBANG SHARE: whatsapp://send?text=...  (localStorage counter)
        ▼
[2] REDIRECTOR   /go.php?t=9         (t=1..12 semua identik → t hanya click-tracking)
        │     location.href + <meta refresh>
        ▼
[3] CLOAKER S1   free.gf920.com/?utm_medium=b00c…412b&utm_campaign=tang4g
        │     • halaman "Loading" — FINGERPRINTING + ANTI-BOT (lihat §2)
        │     • location.replace(hex) → stage-2 dgn fingerprint
        ▼
[4] CLOAKER S2   free.gf920.com/?utm_term=7675059214544273449&utm_content=<fp>
        │     • keputusan server: human mobile ID → offer; bot/analis → decoy
        │     • <meta refresh> → jaringan CPA
        ▼
[5] CPA OFFER    mms.sramms.space/aa449b3e-b49f-4551-abd7-4ba528dcb970
        │            ?partner_ID=27052&pid=27052-dabc31az&subid=M7675059214544273449
        │     • AWS CloudFront (d20yaalqmjo7mn.cloudfront.net)
        ▼
[6] OFFER AKHIR  (mms/subscription — indikasi WAP-billing / Direct Carrier Billing
                  pemotong pulsa; root host 404 tanpa token → butuh klik nyata)
```

**Korelasi token antar-hop** (membuktikan satu funnel):
- `utm_campaign=tang4g` + `utm_medium=b00c…412b` (afiliasi pengirim trafik)
- `utm_term=7675059214544273449` (click/session ID) → dibawa jadi `subid=M7675059214544273449`
- `partner_ID=27052` = `pid=27052-dabc31az` (afiliasi di jaringan CPA sramms)

---

## 2. Cloaker / Fingerprinting di `free.gf920.com` (bukti: `evidence/gf_body.html`)

Halaman "Loading" bukan sekadar loader — ini **anti-analysis cloaker** yang menjelaskan kenapa urlscan/VirusTotal kosong (bot ditolak). Yang dikumpulkan JS-nya:

| Kategori | Sinyal |
|---|---|
| Perangkat | `platform`, `maxTouchPoints`, `screen.avail*`, `devicePixelRatio`, `vendor`, `pixelDepth`, `colorDepth`, `hardwareConcurrency`, `deviceMemory`, timezone offset, `buildID` |
| **Canvas FP** | render "Canvas Fingerprint 🎨" → hash |
| **WebGL FP** | `WEBGL_debug_renderer_info` vendor/renderer, ekstensi, parameter |
| **AudioContext FP** | `OfflineAudioContext` oscillator+compressor |
| **Font FP** | ukuran render karakter Unicode langka + daftar font — **termasuk deteksi font "TeamViewer"** (sinyal analis/remote-desktop) |
| **ANTI-BOT** | `navigator.webdriver`, `callPhantom/_phantom` (PhantomJS), `$cdc_asdjflasutopfhvcZLmcfl_` / `$chrome_asyncScriptInfo` (Selenium/ChromeDriver), `chrome.runtime` absen, `domAutomation(Controller)`, `__nightmare` (Nightmare) → bitmask |
| Konteks | cek iframe (`self===top`) |

**Obfuscation:** hasil di-hash (fungsi custom: `170 ^ charCode ^ (255&i)` + rolling checksum), lalu tujuan disembunyikan sebagai string **hex** `\x68\x74...`. Dekode:

```
https://free.gf920.com/?utm_term=7675059214544273449&utm_content=<device_fingerprint>
```

Server memakai fingerprint itu untuk **cloaking**: pengunjung "bersih" (mobile Indonesia, bukan automation) diarahkan ke offer; scanner/analis diberi halaman kosong/decoy. Kit ini konsisten dengan cloaker CPA komersial (gaya "Loading" + FP script) di dunia sweepstakes/nutra/mobile-subs.

---

## 3. Peta Infrastruktur & Atribusi

| # | Aset | Peran | Registrar/Host | Dibuat | Catatan |
|---|---|---|---|---|---|
| 1 | `1grd.xyz` (+`*`) | Landing/redirector | west.cn · Cloudflare | 2026-06-02 | wildcard, edge CGK |
| 2 | `626cdn.com` | CDN aset multi-negara | **Cloud Yuqu LLC** · Cloudflare R2 | 2026-06-16 | /ID /MY /VN /TH /PH |
| 3 | `gf920.com` / `free.gf920.com` | Cloaker + monetisasi | **Cloud Yuqu LLC** · **INAP 108.178.23.116** | 2026-01-14 | origin ASLI, nginx |
| 4 | `sramms.space` / `mms.sramms.space` | Jaringan CPA offer | NameCheap · **AWS CloudFront** | 2026-05-28 | partner_ID 27052 |

**Simpul atribusi:**
- `626cdn.com` + `gf920.com` = **registrar sama** (Cloud Yuqu LLC / `abuse@diymysite.com`) → **satu operator** yang mengelola front-end umpan + cloaker.
- `sramms.space` (CPA network) kemungkinan **pihak ketiga** (advertiser network) yang membayar operator via `partner_ID=27052`.
- **Origin INAP `108.178.23.116` = server farm cloaking** dengan **165 domain terdaftar unik** (lihat `root-domains_108.178.23.116.txt`): 14×`aff*`, 14×`offer*`, plus `track/verify/secure/click/go`; tema `prize/win/bonus/gift/lucky/vip`; TLD murah (`.shop .online .xyz .top .site .store .click .lol .cfd`). Ini **hub monetisasi bersama** banyak kampanye, bukan hanya "kuota gratis".

---

## 4. Timeline Registrasi

```
2026-01-14  gf920.com        ← tulang punggung cloaker (paling awal)
2026-05-28  sramms.space     ← jaringan CPA offer
2026-06-02  1grd.xyz         ← landing sekali-pakai
2026-06-16  626cdn.com       ← CDN aset multi-negara
2026-04-17  (urlscan)        ← free.gf920.com sudah aktif di alam liar
2026-08-17  HUT RI ke-81     ← tema kampanye "tang4g" diaktifkan
```

Pola: backbone lama & stabil, domain umpan baru & dirotasi mengikuti momen (HUT RI).

---

## 5. Penilaian & Keterbatasan

- **Sifat ancaman:** propagasi viral (memaksa korban menyebar) + monetisasi CPA; offer akhir bergaya `mms`/subscription → risiko **pemotongan pulsa (WAP/DCB)**, plus paparan ke survei/undian/APK tergantung fingerprint & operator seluler.
- **Tidak dieksekusi:** JS cloaker sengaja tidak dijalankan; offer akhir (hop-6) hanya diketahui URL + ID-nya, isi persisnya butuh klik nyata dari perangkat korban.
- **Atribusi individu** tidak mungkin dari luar (WHOIS privacy, Cloudflare, CloudFront). Jalur nyata = **takedown + laporan** ke Cloudflare, INAP, AWS, NameCheap, registrar Cloud Yuqu/west.cn, dan jaringan CPA (`partner_ID 27052`) via aparat.
