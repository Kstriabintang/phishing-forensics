# Paket Submit Sandbox — Menangkap Payload/APK yang Disajikan RTB (AMAN)

Tujuan: memicu offer akhir agar tampil (yang untuk kita hanya 204), lalu **menangkap APK/payload bila disajikan** — dijalankan di **emulator awan terisolasi**, BUKAN di mesinmu. Kamu cukup ambil URL/hash hasilnya, lalu bedah statis lewat `tools/`.

> Kunci: offer hanya muncul untuk **perangkat Android + lokasi Indonesia + klik valid**. Semua setting di bawah dirancang untuk menembus cloaking/anti-bot.

---

## 1. URL target (submit berurutan; #1 paling penting)

| # | URL | Menguji |
|---|---|---|
| 1 | `https://kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98` | rantai penuh dari awal (paling representatif) |
| 2 | `https://kuota-gratis-81gb98.1grd.xyz/go.php/?t=9` | langsung ke redirector → cloaker |
| 3 | `https://free.gf920.com/?utm_medium=b00cccbf77c8ae579fa684fe9c8c5affa17a412b&utm_campaign=tang4g` | langsung ke cloaker fingerprint |
| 4 | `https://mms.sramms.space/aa449b3e-b49f-4551-abd7-4ba528dcb970?partner_ID=27052&pid=27052-dabc31az&subid=M7675059214544273449` | langsung ke jaringan CPA |
| 5 | `https://ldl1.com/link?z=11569507&var=27052&ymid=wv8m6vgk4udrbikk39pqkilu` | langsung ke ad-network RTB (ujung) |

## 2. Setting anti-cloaking (WAJIB)

- **Device/OS:** Android (mobile) — **bukan** desktop/Windows.
- **Lokasi/Geo:** **Indonesia (ID)**. Kalau bisa, **residential/mobile IP ID** (bukan datacenter).
- **User-Agent:**
  ```
  Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36
  ```
- **Accept-Language:** `id-ID,id;q=0.9,en;q=0.8`
- **Referer:** `https://wa.me/` (seolah dari WhatsApp)
- **Interaksi:** izinkan klik/redirect otomatis; tunggu ≥30 dtk (ada countdown + auto-redirect 5 menit).

## 3. Langkah per platform

### A) urlscan.io  (paling mudah, gratis)
1. Buka https://urlscan.io → tempel URL #1.
2. **Options** → Country: **Indonesia**; User-Agent: **Mobile (Android)** (atau custom UA di atas).
3. Visibility: **Unlisted** (jangan Public bila ingin diskret).
4. Setelah selesai: lihat tab **HTTP** (cari transaksi `application/vnd.android.package-archive` atau URL `.apk`), **Indicators**, **Links/Redirects**, dan **Downloads**.

### B) any.run  (interaktif, ada env Android)
1. New Task → **Android** OS bila tersedia; Locale/Geo: Indonesia.
2. Tempel URL #1; jalankan; **klik tombol** "VERIFIKASI/DAPATKAN 81GB" secara manual.
3. Perhatikan **Network** untuk unduhan `.apk`; ekspor sampel dari dalam sandbox (jangan ke mesinmu langsung).

### C) tria.ge (Recorded Future Triage)
1. Submit **URL**; pilih profil **Android** + region.
2. Ambil laporan → bagian **Dropped files / Network** untuk `.apk`.

### D) Hybrid-Analysis / VirusTotal
- HA: submit URL, lihat "Extracted files/URLs".
- VT: submit URL → tab **Relations/Details**; bila ada file terunduh, VT tampilkan hash → bisa diambil.

## 4. Yang dicari (indikator payload)
- Response header `content-type: application/vnd.android.package-archive`
- URL berakhiran `.apk` di rantai request
- Halaman "install aplikasi untuk verifikasi/klaim" (offer install-APK)
- Atau klasifikasi offer non-APK: langganan WAP/pulsa, survei, "kamu menang", PWA.

## 5. Bila APK ditemukan → bedah AMAN di Linux
```bash
cd "/home/clown/Documents/Bintang/MY GITHUB/FORENSIC/2026-08-18_kuota-gratis-81gb-hutri81"
tools/safe_fetch_apk.sh "<URL-APK-dari-sandbox>" kuota81gb_sample
tools/dissect_apk_static.sh ../_QUARANTINE_DO_NOT_EXECUTE/kuota81gb_sample.apk.quarantine
```
`dissect` = statis penuh: manifest, izin (`SEND_SMS`/`READ_SMS`?), endpoint HTTP, **token Telegram/bot**, C2. Aman — tak menjalankan APK.

## 6. Opsi tercepat: auto-submit dari mesin ini
Daftar **urlscan API key gratis** (https://urlscan.io/user/signup → Settings → API), lalu simpan:
```bash
echo 'export URLSCAN_API_KEY=xxxxxxxx' >> ~/.zshrc && source ~/.zshrc
```
Kabari aku → aku submit scan **mobile + geo ID** via API, poll hasilnya, dan tarik daftar `.apk`/redirect otomatis ke folder kasus.

---

### Ringkas untuk ditempel ke form sandbox
```
URL      : https://kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98
Country  : Indonesia (ID)
Device   : Android / Mobile
UA       : Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36
Lang     : id-ID,id;q=0.9
Referer  : https://wa.me/
Tunggu   : >30 dtk, izinkan redirect
```
