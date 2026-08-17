# Payload Analysis — Apakah ada aplikasi / token Telegram?

Menjawab pertanyaan: *"cari payload asli; kalau ada APK unduh aman untuk dibedah; pasti ada token Telegram?"*

## Ringkasan: **TIDAK ada APK tetap, TIDAK ada token Telegram** — dan itu memang sesuai jenis scam-nya.

---

## 1. Apakah kit mengumpulkan/mencuri data?

Landing punya kolom nomor:
```html
<input type="char" placeholder="Nomor ponsel" id="name" name="Phone" onkeypress="return numberonly(event);">
```
**Tapi:** tidak ada `<form action>`, tidak ada `fetch/XHR/POST`, tidak ada `FormData`, tidak ada `api.telegram.org`, tidak ada `bot<id>:<token>`, tidak ada endpoint `.php` penerima — **di seluruh bukti** (`grep -r` bersih).

Nomor itu **hanya dipakai di browser** (`$("#getname").html($("#name").val())`) untuk animasi "sedang mengecek nomormu". **Nomor TIDAK PERNAH dikirim ke server.** Ini teater rekayasa sosial, bukan pencurian data.

➡️ **Bukan kit pencuri kredensial.** Token Telegram lazim ada di kit yang *meng-exfiltrate* OTP/login bank/e-wallet — arketipe berbeda. Kampanye ini tidak meng-exfiltrate apa pun.

## 2. Apakah ada APK / aplikasi?

Jejak offer akhir:
```
mms.sramms.space/<GUID>?partner_ID=27052&...
   └─302─▶ https://ldl1.com/link?z=11569507&var=27052&ymid=wv8m6vgk4udrbikk39pqkilu
             └─ HTTP 204 (KOSONG) untuk request kita
```
- `ldl1.com` = **jaringan iklan pop/RTB bersama** (urlscan: dipakai banyak afiliasi, `var=12020/27052`, template `{SOURCE_ID}/{CLICK_ID}`, banyak `z=` zone).
- Dari IP datacenter/tanpa sesi-klik mobile valid → **204 No Content** (tak ada offer disajikan).
- Cek APK langsung: `626cdn.com/**/**.apk` semua **404**; host beraroma app (`download.mobilezella.com`, `beatmobi.com`, `playzix.com`, dst.) tidak menyajikan `.apk`.

➡️ **Tidak ada payload/APK tunggal.** Offer akhir **dirutekan real-time**: tiap klik nyata dijual ke ad-network, yang menyajikan penawaran pemenang lelang saat itu (langganan WAP, "kamu menang", PWA, kadang install-APK) — bergantung geo/perangkat/waktu. Payload tidak deterministik.

## 3. Klasifikasi sebenarnya

**Traffic-arbitrage / CPA pop-ad funnel.** Monetisasi = **menjual klik** ke `ldl1.com`, bukan mencuri data atau menyebar malware tetap. Umpan "kuota gratis" hanya generator trafik; propagasi via gerbang-share WhatsApp memperbesar volume klik gratis.

---

## 4. Kalau tetap mau menangkap varian APK (AMAN)

Karena payload hanya muncul untuk **perangkat mobile Indonesia asli dengan klik valid**, cara aman menangkapnya **tanpa mengeksekusi apa pun di mesinmu**:

1. **Sandbox awan mobile** — masukkan URL landing ke:
   - `any.run` (pilih env Android), `hybrid-analysis.com`, `tria.ge` (Recorded Future Triage), `urlscan.io` (UA mobile), `VirusTotal` (URL + Relations).
   - Mereka merender sebagai HP di emulator terisolasi dan **menangkap APK bila disajikan** + laporan perilaku. Kamu cukup ambil URL/hash-nya.
2. **Kalau sandbox memberi URL `.apk`** → unduh aman ke karantina:
   ```bash
   tools/safe_fetch_apk.sh "<url-apk>" nama_sampel
   tools/dissect_apk_static.sh ../../_QUARANTINE_DO_NOT_EXECUTE/nama_sampel.apk.quarantine
   ```
   `dissect_apk_static.sh` = **100% statis** (unzip/strings/manifest/izin, cari token Telegram, C2, `SEND_SMS`, endpoint). Aman di Linux.
3. **JANGAN** `adb install`/emulator biasa. APK di Linux hanya ZIP mati selama tidak di-install.

> Infrastruktur karantina sudah disiapkan: `_QUARANTINE_DO_NOT_EXECUTE/` (+ `README_SAFETY.txt`, `.gitignore` agar sampel tak ikut ke repo).

---

## 5. Kesimpulan

| Ekspektasi | Realita (berbukti) |
|---|---|
| Ada aplikasi/APK | Tidak tetap — offer RTB via `ldl1.com`, 204 utk kita |
| Pasti ada token Telegram | Tidak — kit tak meng-exfiltrate; nomor HP tak dikirim |
| Pencuri data | Bukan — ini funnel arbitrase trafik/CPA |

*Jika di sesi lain kamu bawa scam yang MEMANG minta OTP/login (mis. "e-wallet"/"bank"/"cek resi") → itu arketipe pencuri-data; di sanalah token Telegram/endpoint `.php` biasanya ketemu, dan alur karantina di atas siap dipakai.*
