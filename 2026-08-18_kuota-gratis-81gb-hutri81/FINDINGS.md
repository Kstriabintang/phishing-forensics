# 🔍 Findings Register — Detailed

Setiap temuan: **bukti** (file di repo) + **sumber/verifikasi** (link OSINT) + **keyakinan**.
Referensi link lengkap: [`REFERENCES.md`](REFERENCES.md). IOC mesin: [`IOC.txt`](IOC.txt).

Legenda keyakinan: 🟢 Confirmed (bukti langsung) · 🟡 Strong (korelasi kuat) · 🔵 Historical/OSINT lead.

---

## A. Rantai serangan & mekanisme

### F-01 · Umpan landing + gerbang-share paksa 🟢
Halaman `kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98` menampilkan post FB palsu "GRATIS 81GB" dan **memaksa share WhatsApp** (`whatsapp://send?text=…`, penghitung `localStorage`) sebelum tombol DAPATKAN aktif.
- Bukti: `evidence/phish_body.html` (baris `text1`, `shareWhatsApp()`), `screenshots/01_landing_merdeka_81gb.png`
- Verifikasi: urlscan [01a01152-4886](https://urlscan.io/result/01a01152-4886-778c-85cb-239aff0aa3bc/)

### F-02 · Bukti sosial palsu dari CDN multi-negara 🟢
Nama/komentar/foto palsu di-*inject* server-side via cookie dari `626cdn.com`. Folder per-negara `/Indonesia /Malaysia /Vietnam /Thailand /Philippines` (HTTP 200).
- Bukti: `evidence/phish_headers.txt` (Set-Cookie `pics/comments/names/loclang`)

### F-03 · Redirector `/go.php` (param `t` = click-tracking) 🟢
`t=1..12` semuanya menuju link payout yang sama → `t` hanya penghitung klik.
- Bukti: `evidence/go_body.html`

### F-04 · Cloaker fingerprint perangkat `free.gf920.com` 🟢
Mengumpulkan Canvas, WebGL, AudioContext, font (termasuk deteksi font **TeamViewer**), lalu `location.replace` ke target **hex-encoded**.
- Bukti: `evidence/gf_body.html`, `screenshots/03_cloaker_free-gf920_loading.png`
- Detail: `analysis/technical-analysis.md` §2

### F-05 · Anti-bot / anti-analisis 🟢
Deteksi `navigator.webdriver`, `callPhantom/_phantom` (PhantomJS), `$cdc_…` (Selenium), `__nightmare`, `domAutomation` → bitmask. Inilah sebab urlscan/VT "bersih".
- Bukti: `evidence/gf_body.html`
- Konteks: [Varonis — 1Campaign cloaking](https://www.varonis.com/blog/1campaign), [Varonis — AI hides malicious sites](https://www.varonis.com/blog/ai-hides-malicious-sites)

### F-06 · Rotasi partner RTB (bukan payload tetap) 🟢
Stage-2 cloaker merutekan ke **`ldl1.com`** ATAU **`srvmediahost.com`→`obqj3.com`**; keduanya 204 untuk IP datacenter.
- Bukti: urlscan [go.php→obqj3](https://urlscan.io/result/01a01156-fd3d-719e-b164-551fa2162c28/), [cloaker→ldl1](https://urlscan.io/result/01a01152-4da8-742f-9115-4b876c71bffd/), [mms→ldl1](https://urlscan.io/result/01a01157-0141-772e-871d-1cdeb0c80765/)

## B. Infrastruktur & de-cloaking

### F-07 · Origin asli #1 — `108.178.23.116` (INAP Chicago, AS32475) 🟢
Origin `free.gf920.com` (grey-cloud). Hub cloaking/CPA.
- Verifikasi: [ipinfo](https://ipinfo.io/108.178.23.116), [VirusTotal](https://www.virustotal.com/gui/ip-address/108.178.23.116), [OTX](https://otx.alienvault.com/indicator/ip/108.178.23.116)

### F-08 · Origin asli #2 — `95.217.42.163` (Hetzner Helsinki, AS24940) 🟢
`srvmediahost.com` grey-cloud → origin. ~16 domain "media/serv/track" (6 hidup).
- Bukti: `evidence/reverse-ip_95.217.42.163.txt`
- Verifikasi: [ipinfo](https://ipinfo.io/95.217.42.163), [OTX](https://otx.alienvault.com/indicator/ip/95.217.42.163)

### F-09 · Skala jaringan — 548 host / 506 domain, 222 hidup 🟢
Reverse-IP + OTX passive-DNS; 320 mati (rotasi), 14+ domain DGA `<gibberish>.<gibberish>.shop`.
- Bukti: `analysis/host-inventory.tsv`, `analysis/hosts_LIVE_CORE.txt`, `analysis/network-map.md`
- Verifikasi: [OTX 108.178.23.116 passive-DNS](https://otx.alienvault.com/indicator/ip/108.178.23.116)

### F-10 · Cross-link cluster → satu operator 🟡
`mediaservingcd.com` (cluster Hetzner) resolve ke `104.219.250.37` = cluster Namecheap-PHX (dari origin INAP). → INAP + Hetzner + Namecheap satu operator.
- Bukti: `analysis/attribution-and-osint.md` §2

## C. Produk kedua & analitik

### F-11 · Analitik Plausible self-hosted; ID kampanye 🟢
`tj.16gift.com`/`tj.657g.xyz` = Plausible. POST `/api/event` `{"d":"id-data01"}` (kuota), `data-domain="bot.com"` (kuis). Dashboard `plausible.16gift.com` privat (403).
- Bukti: `evidence/telegram-quiz/plausible_script_tj.16gift.com.js`

### F-12 · Produk kedua — Telegram Mini App "Quiz" (earn-to-payout) 🟢
`16gift.com/njb/` — `telegram-web-app.js`, backend `api.php?cmd=…` (`{"ok":false,"status":4002}`), referral `psid`, `payout.php`. Klaim "500K+ Withdrawal", bukti-bayar palsu "@Putri123 … Venmo".
- Bukti: `evidence/telegram-quiz/16gift_quiz.html`, `main.js`, `api.php_response.txt`, `screenshots/05_telegram_quiz_16gift.png`

## D. Atribusi

### F-13 · Silsilah 2018 — `gf920.com` = judi Mandarin "和信娱乐城" 🔵
Login 账号/密码, menu 彩票投注/真人视讯/存款取款. Kontak: **QQ 752562222**, **WeChat widlc6588**, domain **hx1.vip**.
- Bukti: `evidence/wayback/gf920.com_2018_hexin-gambling-login.html`, `screenshots/04_gf920_2018_hexin-gambling-login.png`
- Sumber: [Wayback 2018-08-05](https://web.archive.org/web/20180805121500/http://gf920.com/)

### F-14 · Domain aged di-repurpose 🔵
`16gift.com` (2012) = toko hadiah/bunga Tiongkok (ASP) → reputasi aged untuk lolos filter.
- Sumber: [Wayback 16gift.com](http://web.archive.org/web/2012*/16gift.com*)

### F-15 · Operator berbahasa Mandarin 🟡
Registrar Tiongkok (`west.cn`, Hefei Juming); telemetry `tj`=统计 (tǒngjì); silsilah judi; QQ/WeChat.
- Verifikasi: [VT gf920.com](https://www.virustotal.com/gui/domain/gf920.com), [VT 16gift.com](https://www.virustotal.com/gui/domain/16gift.com)

## E. Penilaian & korelasi

### F-16 · Bukan pencuri data / tanpa token Telegram / tanpa APK tetap 🟢
Varian ini dimonetisasi via RTB; nomor HP di form tak dikirim; tak ada `api.telegram.org`/`bot<id>:token`; offer akhir 204 (RTB).
- Bukti: `analysis/payload-analysis.md`

### F-17 · Opsec operator solid (tak ada kunci bocor) 🟢
`.git/.env` 403, listing 403, `api.php` ter-gate, dashboard privat, token server-side.
- Bukti: `analysis/deep-dive-round2.md` §4

### F-18 · Konfirmasi otoritas — Kemenkomdigi nyatakan HOAKS 🟢
Media Indonesia meliput; disebut varian pengumpul-data (nama/alamat/Telegram-WA, share 5 grup/15 kontak, pinjol).
- Sumber: lihat [REFERENCES.md § Berita](REFERENCES.md)

---

*Semua bertanggal 2026-08-18. Bukti mentah ber-hash di `evidence/SHA256SUMS.txt`. Semua teknik pasif/read-only.*
