# DOSSIER JEJAK DIGITAL — "Kuota Gratis 81GB HUT RI ke-81"

**Case** `2026-08-18_kuota-gratis-81gb-hutri81` · **Analis** clown · **Tanggal** 2026-08-18 (GMT+7)
Konsolidasi seluruh bukti keras: recon pasif + OTX/passive-DNS + 5 render langsung urlscan.io.
Semua tangkapan mentah di `evidence/` (manifest `SHA256SUMS.txt`). Semua interaksi **pasif/read-only**.

---

## 1. VONIS
**Scam umpan-hadiah viral → funnel arbitrase trafik / CPA pop-ad multi-jaringan.** Bukan pencuri kredensial, **tanpa exfiltrasi data, tanpa token Telegram, tanpa APK tetap**. Monetisasi = menjual klik ke jaringan iklan RTB (rotasi antar-partner). Propagasi paksa via gerbang-share WhatsApp.

---

## 2. RANTAI SERANGAN LENGKAP (terbukti via render urlscan)

```
Pesan WA ─▶ kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98   (landing, Cloudflare edge CGK)
   │          ├─ aset palsu: 626cdn.com (foto/nama/komentar; folder /ID /MY /VN /TH /PH)
   │          └─ telemetry: tj.16gift.com/api/event   ("tj"=统计 tongji → operator Mandarin)
   ├─ GERBANG SHARE  whatsapp://send?text=…   (localStorage counter)
   ▼
   /go.php?t=9 ─▶ free.gf920.com  [CLOAKER: fingerprint Canvas/WebGL/Audio/Font + anti-bot]
   ▼            hex→ free.gf920.com/?utm_term=<sesi>  [stage-2: keputusan]
   ▼
   ┌─ SMARTLINK ROTASI PARTNER RTB (bergantung sesi/geo) ─────────────────────┐
   │  Varian A:  mms.sramms.space/<GUID>?partner_ID=27052 ─▶ ldl1.com/link?z=… │
   │  Varian B:  srvmediahost.com/nlp/index.php?z=…&url_bnm_redirect= ─▶ obqj3.com/link?z=… │
   └──────────────────────────────────────────────────────────────────────────┘
   ▼
   Offer akhir (RTB) → 204 untuk IP datacenter; payload nyata hanya utk IP MOBILE ID + klik valid
```

**Bukti rotasi partner (dari 5 render):** stage-2 `free.gf920.com` mengirim ke **`ldl1.com`** (scan #3,#4,#5) ATAU **`srvmediahost.com`→`obqj3.com`** (scan #2). Semua ujung **204** dari node datacenter SG → geo-gate final = **IP seluler Indonesia asli**.

---

## 3. INFRASTRUKTUR — SEMUA ASET (bukti keras)

### 3a. Front-end umpan (Cloudflare-fronted, dirotasi)
| Aset | Peran | Registrar | Dibuat | Catatan |
|---|---|---|---|---|
| `1grd.xyz` (+`*` wildcard) | landing/redirector `/go.php` | west.cn (CN) | 2026-06-02 | edge CGK Jakarta |
| `626cdn.com` | CDN aset multi-negara | Cloud Yuqu LLC | 2026-06-16 | Cloudflare R2; /ID/MY/VN/TH/PH |
| `16gift.com` / `tj.16gift.com` | **telemetry/analitik** | Hefei Juming (CN) | 2023-12-30 | `/api/event`; "tj"=统计 |

### 3b. Cloaker + monetisasi (ORIGIN ASLI terekspos)
| Aset | Peran | Registrar | Dibuat | **Origin asli** |
|---|---|---|---|---|
| `gf920.com`/`free.gf920.com` | cloaker fingerprint | Cloud Yuqu LLC | 2026-01-14 | **108.178.23.116** — INAP Chicago (AS32475), nginx |
| `sramms.space`/`mms.sramms.space` | jaringan CPA offer | NameCheap | 2026-05-28 | AWS CloudFront |
| **`srvmediahost.com`** | cloaker/smartlink `/nlp/` | NameCheap | 2025-11-11 | **95.217.42.163** — Hetzner Helsinki (AS24940), nginx/1.26.0 |

### 3c. Jaringan iklan RTB (ujung monetisasi)
| Aset | Peran | Registrar | Dibuat | Host |
|---|---|---|---|---|
| `ldl1.com` | ad-network pop/RTB | — | — | Cloudflare (zone dinamis) |
| `obqj3.com` | ad-network redirect (`url_bnm_redirect`) | NameCheap | 2022-03-14 | Cloudflare |
| `a.sssifmobisignal.com` | node smartlink tambahan | NameCheap | 2026-04-13 | 162.255.119.12 (NameCheap) |

---

## 4. DUA ORIGIN ASLI + KLASTERNYA (di luar Cloudflare)

**Origin #1 — `108.178.23.116` (INAP/Internap, Chicago, AS32475)**
Hub cloaking/CPA utama. **548 host / 506 domain** (reverse-IP + OTX passive-DNS), **222 hidup** (per 2026-08-18): 193 di IP ini + cluster sekunder `2.59.170.20` (WorldStream NL ×7), `104.219.250.37` (NameCheap PHX ×5). Detail penuh + tag: `analysis/network-map.md`, `analysis/host-inventory.tsv`, `analysis/hosts_LIVE_CORE.txt` (67 host inti).

**Origin #2 — `95.217.42.163` (Hetzner, Helsinki, AS24940)** — SEMUA 6 HIDUP (200):
`srvmediahost.com` · `srvmedianet.com` · `srvnewmedia.com` · `smartmediasrv.com` · `doubletrk.com` · `baitechi.com`
Cluster cloaker/tracker "srvmedia/track" milik operator yang sama. Bukti: `evidence/reverse-ip_95.217.42.163.txt`.

**Semua ASN tersentuh (5 render):** AS13335 Cloudflare · AS32475 Internap · AS24940 Hetzner · AS16509 Amazon · AS54113 Fastly · AS22612 NameCheap.

---

## 5. FINGERPRINT / TOKEN / ID (untuk klaster & atribusi)
| Jenis | Nilai |
|---|---|
| Afiliasi (gf920→sramms) | `utm_medium=b00cccbf77c8ae579fa684fe9c8c5affa17a412b` · `partner_ID=27052` · `pid=27052-dabc31az` |
| Afiliasi (gf920→srvmediahost) | `var=a4c225c6ece6568874902d43d340ac7e` |
| Campaign | `utm_campaign=tang4g` · `t=9` (go.php) |
| Zone RTB | ldl1 `z=11569507`,`10474180`,`10950458`… · obqj3/srvmediahost `z=11299758` |
| Session/click | `subid=M<utm_term>` · `ymid=<klik>` |
| **Atribusi bahasa** | **Mandarin** — registrar `west.cn` & `Hefei Juming` (CN); subdomain **`tj`=统计 (tǒngjì)** |
| Signature kit | cookie `pics/comments/names/loclang`; daftar nama palsu tetap; DGA `<gibberish>.<gibberish>.shop` |

---

## 6. BUKTI KERAS — RENDER LANGSUNG urlscan.io (5 scan, node SG, UA mobile-ID)
| # | Target | Hasil | UUID |
|---|---|---|---|
| 1 | landing | reach 626cdn + tj.16gift.com telemetry | `01a01152-4886-778c-85cb-239aff0aa3bc` |
| 2 | go.php | chain → srvmediahost → obqj3 → 204 | `01a01156-fd3d-719e-b164-551fa2162c28` |
| 3 | cloaker | chain → ldl1 → 204 | `01a01152-4da8-742f-9115-4b876c71bffd` |
| 4 | mms offer | → ldl1 → 204 | `01a01157-0141-772e-871d-1cdeb0c80765` |
| 5 | ldl1 | 204 | `01a01157-04c6-7159-b314-4764f30466fb` |

JSON + **screenshot** tiap scan di `evidence/urlscan/`. Screenshot landing = banner "MERDEKA! HUT RI ke-81 — GRATIS 81GB KUOTA", tombol DAPATKAN, social-proof palsu 135K/23K/13K. **Tak ada APK/berkas terunduh di semua scan.**

---

## 7. TIMELINE REGISTRASI
```
2022-03-14  obqj3.com          (ad-network, lama)
2023-12-30  16gift.com         (telemetry, lama)
2026-01-14  gf920.com          (cloaker backbone)
2025-11-11  srvmediahost.com   (cloaker Hetzner)
2026-04-13  sssifmobisignal.com
2026-05-28  sramms.space       (CPA)
2026-06-02  1grd.xyz           (landing sekali-pakai)
2026-06-16  626cdn.com         (CDN umpan)
2026-08-17  HUT RI ke-81 → tema "tang4g" aktif
```
Pola: backbone lama & stabil (obqj3, 16gift, gf920), umpan baru dirotasi mengikuti momentum.

---

## 8. TAKEDOWN / PELAPORAN (target diperbarui)
1. **Cloudflare abuse** (`abuse.cloudflare.com`) → 1grd.xyz, 626cdn.com, gf920.com(apex), 16gift.com, obqj3.com, ldl1.com.
2. **INAP** → origin `108.178.23.116`. **Hetzner** (`abuse@hetzner.com`) → origin `95.217.42.163` (+6 domain srvmedia).
3. **NameCheap** (`abuse@namecheap.com`) → srvmediahost.com, sramms.space, obqj3.com, sssifmobisignal.com. **west.cn** → 1grd.xyz. **Cloud Yuqu/diymysite.com** → gf920/626cdn. **Hefei Juming** → 16gift.com.
4. **AWS** → CloudFront mms.sramms.space. 
5. **Indonesia:** aduankonten.id (Kominfo) · BSSN/ID-CERT · operator yang dicatut.
6. Submit semua URL ke Google Safe Browsing; urlscan record (unlisted) sudah ada.

---

## 9. STATUS PAYLOAD / APK
Tidak tertangkap dari node datacenter (semua 204). Payload hanya untuk **IP seluler ID asli + klik valid**. Infrastruktur karantina siap (`_QUARANTINE_DO_NOT_EXECUTE/` + `tools/safe_fetch_apk.sh` + `tools/dissect_apk_static.sh`); cara menangkap aman di `analysis/sandbox-submission.md` & `analysis/payload-analysis.md`.

---

## 10. ADENDUM — Deep-Dive Ronde 2 & 3 (ringkas)

**Ronde 2 — analitik & produk kedua** (detail: `analysis/deep-dive-round2.md`):
- **Self-hosted Plausible Analytics** (`tj.16gift.com`, `tj.657g.xyz`). ID kampanye internal terbongkar: **`id-data01`** (funnel kuota), **`bot.com`** (kuis).
- **Produk kedua:** **Telegram Mini App "Quiz"** (`16gift.com/njb/`) — scam **earn-to-payout** ("500K+ Withdrawal", "$300/bulan"), backend `api.php` (ber-`cmd`, kode status `4002`), sistem referral `psid`, `payout.php`. Screenshot `05`.
- Domain baru: `657g.xyz` (Dynadot 2026-07-31), `plausible.16gift.com`.

**Ronde 3 — atribusi & korelasi eksternal** (detail: `analysis/attribution-and-osint.md`):
- **Silsilah:** `gf920.com` (Wayback 2018) = situs judi Mandarin **"和信娱乐城" (Hexin Entertainment City)** — login 账号/密码, 彩票投注. Kontak era-2018: **QQ 752562222**, **WeChat widlc6588**, domain **hx1.vip**. Aged-domain di-repurpose. Screenshot `04`.
- **Cross-link cluster:** `mediaservingcd.com` menautkan origin Hetzner ↔ cluster Namecheap-PHX → **INAP + Hetzner + Namecheap = satu operator**.
- **Korelasi eksternal:** **Kemenkomdigi/Kominfo menyatakan HOAKS**; media Indonesia meliput. Varian **data-harvesting** (nama/alamat/Telegram-WA, share 5 grup/15 kontak, pinjol) dilaporkan publik — berbeda dari varian **CPA/RTB** yang dibedah di sini (**multi-varian**, satu tema "81GB").
- **Uji "cari kunci":** setelah 3 ronde, **tidak ada rahasia terekspos** — opsec operator solid (dotfile 403, listing 403, API ter-gate, dashboard privat, token server-side). Semua analisis **pasif/OSINT**; batas hukum tidak dilewati.

## 11. Bukti Visual
Galeri lengkap: [`SCREENSHOTS.md`](SCREENSHOTS.md) — landing 81GB, render urlscan, cloaker, situs judi 2018, Telegram quiz.

---

*Semua temuan bertanggal 2026-08-18; jaringan dinamis. Bukti mentah + hash tersedia untuk verifikasi independen.*
