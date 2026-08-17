# urlscan.io Live-Render Results (2026-08-18)

Dua scan disubmit via API (node **Singapura** — urlscan tak punya node ID), UA mobile Android + `Accept-Language: id-ID`, visibility **unlisted**. Render browser sungguhan menjalankan JS cloaker.

| # | Target | Result | Screenshot |
|---|---|---|---|
| 1 | landing `kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98` | `evidence/urlscan/scan1_landing_*.json` · https://urlscan.io/result/01a01152-4886-778c-85cb-239aff0aa3bc/ | `evidence/urlscan/screenshot_01a01152-4886-...png` |
| 3 | cloaker `free.gf920.com/?utm_medium=…&utm_campaign=tang4g` | `evidence/urlscan/scan3_cloaker_*.json` · https://urlscan.io/result/01a01152-4da8-742f-9115-4b876c71bffd/ | `evidence/urlscan/screenshot_01a01152-4da8-...png` |

## Temuan

### Scan #1 (landing) — 2 domain BARU
- Memuat `https://tj.16gift.com/js/script.js` (200) lalu **POST** `https://tj.16gift.com/api/event` (202).
  → **`tj.16gift.com` = telemetry/analitik first-party operator.** Prefix **`tj` = 统计 (tǒngjì, "statistik")** → **sinyal operator berbahasa Mandarin** (selaras registrar Tiongkok `west.cn`).
  `16gift.com`: dibuat **2023-12-30**, registrar **Hefei Juming Network (Tiongkok)**, di belakang Cloudflare → backbone tracking lama & stabil.
- Domain tersentuh: `kuota-gratis-81gb98.1grd.xyz`, `626cdn.com`, `tj.16gift.com`, jsDelivr/jQuery, cloudflareinsights.
- **Screenshot:** banner "MERDEKA! HUT RI ke-81 — GRATIS 81GB KUOTA", tombol **DAPATKAN**, social-proof palsu (135K/23K/13K).

### Scan #3 (cloaker) — rantai + 1 domain BARU
```
200  free.gf920.com/?utm_medium=…&utm_campaign=tang4g        (stage-1 fingerprint)
200  free.gf920.com/?utm_term=7675093797620940902            (stage-2, session baru)
204  ldl1.com/link?z=10474180&var=27052&ymid=wcq81t6kq75h…   (RTB — no-fill utk IP datacenter)
```
- Domain baru **`a.sssifmobisignal.com`** (referensi/preconnect pasca-fingerprint). `sssifmobisignal.com`: dibuat **2026-04-13**, **NameCheap**, IP **162.255.119.12** (AS22612 Namecheap) → node cloaker/smartlink tambahan.
- **Zone ldl1 berubah** (`z=10474180` vs `11569507` sebelumnya) → konfirmasi **zone dinamis per-sesi** dari RTB. `var=27052` (afiliasi) **tetap**.

## Kesimpulan
- Render browser SG **tetap 204** di ldl1 → **konfirmasi kuat: payload/APK hanya untuk IP mobile Indonesia asli + klik valid.** Tak ada APK/berkas terunduh di kedua scan.
- Nilai tambah: **3 IOC baru** (`tj.16gift.com`, `16gift.com`, `a.sssifmobisignal.com`/`sssifmobisignal.com`) + bukti visual + **atribusi bahasa Mandarin** (`tj`=统计).
- Verdict urlscan "malicious:false" = **wajar** (cloaker + RTB menghindari deteksi otomatis; justru menegaskan kecanggihan evasion, bukan tanda aman).

## Langkah untuk BENAR-BENAR menangkap APK
Butuh **IP mobile Indonesia asli** (operator ID) + klik nyata. Opsi: any.run/tria.ge dengan exit-node/residential ID, atau perangkat uji terisolasi di jaringan seluler ID. urlscan free (node SG, datacenter) tidak cukup menembus geo-gate terakhir.
