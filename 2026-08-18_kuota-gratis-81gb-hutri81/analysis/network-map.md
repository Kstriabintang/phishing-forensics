# Network Map — Origin Farm `108.178.23.116`

Pemetaan penuh & uji-hidup 177 host yang di-*co-host* di server asal (INAP Chicago) — simpul monetisasi/cloaking tempat "kuota gratis 81GB" bermuara. Data mentah: `liveness.tsv` · daftar host: `hosts.txt` · domain unik: `root-domains_108.178.23.116.txt`.

> Metode: resolve DNS + probe HTTPS (dan fallback HTTP + `-k`) per host, paralel 24, timeout 8–9 dtk, hanya status/server/redirect/title. **404 di root = HIDUP** (cloaker hanya melayani path bertoken; bandingkan `mms.sramms.space/` = 404 tapi `/<GUID>?params` = offer).

---

## 1. Uji-Hidup (per 2026-08-18)

| Status | Jumlah | Arti |
|---|---:|---|
| **HIDUP — HTTPS 404 (nginx)** | 136 | Server aktif, cloaker-gated |
| **HIDUP — HTTP-only 301** | 37 | Sertifikat TLS SNI tak cocok, port 80 hidup → paksa HTTPS |
| **HIDUP — pindah IP** | 1 | `offersnew.fun` → `91.108.119.153` (origin kedua) |
| **MATI — tanpa DNS** | 3 | `wwv.ultrasindmars.work`, `wwv.shiptrickon.wiki`, `wvw.buildontoptok.help` |
| **TOTAL** | 177 | |

### => **HIDUP 174 / 177 (98,3%)** — jaringan sangat aktif.

**Hosting:**
- **173 host** masih menunjuk origin **`108.178.23.116`** (AS32475 Internap/INAP, Chicago, nginx).
- **1 host** pindah ke **`91.108.119.153`** (origin saudara — kandidat pivot berikutnya).
- **3 host** benar-benar mati (domain/DNS dilepas).
- Semua host "404" menyajikan header `server: nginx` yang sama → **satu stack**.

---

## 2. Pola Domain-Generation (sidik jari operator)

**14 domain "kembar" `<gibberish>.<gibberish>.shop`** — nama gibberish-yang-bisa-diucap, dibuat otomatis lalu dirotasi:

```
kaverod.kaverod.shop      kivorax.kivorax.shop      merkulashop.merkulashop.shop
paxenro.paxenro.shop      praxemio.praxemio.shop    qarivon.qarivon.shop
syntrad.syntrad.shop      tavindal.tavindal.shop    werniqax.werniqax.shop
xelmoruq.xelmoruq.shop    xorvameq.xorvameq.shop    yolivashop.yolivashop.shop
zemorix.zemorix.shop      zoltena.zoltena.shop
```

Ciri kuat **Domain Generation Algorithm (DGA)** / registrasi massal otomatis — cepat dibuat, cepat dibuang, sulit di-blacklist manual.

---

## 3. Klaster Fungsi (prefix subdomain)

| Prefix | # | Peran dugaan |
|---|---:|---|
| `aff*` | 12 | link afiliasi (traffic-in) |
| `offer*` | 6 | halaman offer |
| `go*` | 7 | redirector (mirip `go.php`) |
| `free*` | 6 | umpan "gratis" (spt `free.gf920.com`) |
| `m*` / `mon*` | 6 / 4 | mobile / monitoring |
| `track*` | 3 | pelacakan klik |
| `verify*` / `secure*` | 2 / 2 | halaman "verifikasi" palsu |
| `get*` | 3 | landing hadiah |
| `click*` / `cl*` | 2 / 2 | click-tracker |
| `dash*` / `app*` | 2 / 2 | dashboard afiliasi / app |
| `wwv*` / `wvw*` / `ww*` | 3 / 1 / 2 | typosquat `www` |

Peran menyeluruh: **traffic-in (aff/free) → redirector (go/click/track) → cloaker → offer/verify** — pipeline CPA lengkap dalam satu server.

---

## 4. Distribusi TLD (registrable)

```
.com 52   .shop 25   .online 17   .xyz 14   .top 9   .site 8   .store 5
.click 4  .lol 3     .cfd 3       .cc 3     .wiki 2  .space 2  .org 2  .ng 2
```

Dominan TLD **murah & sering-disalahgunakan** (`.shop .online .xyz .top .site .store .click .lol .cfd`) — konsisten dengan operasi rotasi-domain berbiaya rendah. (`.com` banyak dipakai untuk host yang lebih "tetap" seperti `gf920.com`, `playzix.com`, `flyinmob.com`, `beatmobi.com`.)

---

## 5. Host "Tetap" yang Menonjol (kandidat inti, bukan throwaway)

`gf920.com`/`free.gf920.com` (cloaker utama kasus ini), `playzix.com`+`games.playzix.com`, `flyinmob.com`+`alpha.flyinmob.com`, `beatmobi.com`, `accessflows.cc`, `medioffer.shop`, `mobgifts.cfd`, `offerspubhub.online`, `rew76.com`, `aprizedaily.com`, `99offers.site`. Domain-domain `.com` beridentitas "brand" ini lebih layak dilacak untuk atribusi daripada domain kembar `.shop`.

---

## 6. Kesimpulan

- Server `108.178.23.116` adalah **hub cloaking/CPA bersama yang aktif** — **174/177 host hidup**, semuanya nginx satu stack.
- "Kuota Gratis 81GB HUT RI" hanyalah **satu umpan** yang menyalurkan ke hub ini; ratusan domain lain (prize/win/bonus/gift/offer) berjalan paralel dengan pola & infrastruktur sama.
- **Origin kedua `91.108.119.153`** (via `offersnew.fun`) = perluasan jaringan → target pemetaan lanjutan.
- Untuk takedown berdampak, tekanan pada **origin INAP** + registrar host "tetap" `.com` lebih efektif daripada mengejar domain kembar `.shop` yang sekali-pakai.

---

## 7. Pemetaan Diperluas (OTX passive-DNS) — 548 host / 506 domain

§1–§6 di atas dari reverse-IP hackertarget (177 host, snapshot). **Diperluas** dengan OTX AlienVault passive-DNS untuk origin `108.178.23.116` (500 hostname historis) → gabungan **548 host unik / 506 domain terdaftar**. Semua di-resolve ulang (DNS) 2026-08-18. Data: `host-inventory.tsv` (ber-tag lengkap), `resolve_all.tsv` (mentah), `hosts_all.txt`, `evidence/otx_passivedns_108.178.23.116.txt`.

### Distribusi hosting (multi-origin)

| Hosting | # | Ket. |
|---|---:|---|
| **LIVE — INAP `108.178.23.116`** | 193 | origin utama, AS32475 Chicago |
| **LIVE — lain (alt IP)** | 17 | tersebar |
| **LIVE — WorldStream `2.59.170.20`** | 7 | AS49981 Rotterdam NL (cluster sekunder) |
| **LIVE — Namecheap `104.219.250.37`** | 5 | AS22612 Phoenix US (cluster sekunder) |
| **PARKED** | 5 | `103.224.182/212.x` (Trellian) & `7.7.7.7` = domain dibuang |
| **MATI (tanpa DNS)** | 320 | domain lama sudah dilepas (rotasi) |
| **CNAME (transient)** | 1 | error resolve sementara |
| **TOTAL** | 548 | |

=> **222 host HIDUP** tersebar di **≥4 origin** (INAP primer + WorldStream + Namecheap + alt). **320 mati** = bukti rotasi domain besar-besaran. **Origin "kedua" `91.108.119.153` (Hostinger Jakarta) = SHARED HOSTING — bukan infra kampanye** (tenant tak terkait: aqiqahbandung.id, forexcircles.com, `*.cdn.hstgr.net`); `offersnew.fun` cuma numpang → **pivot buntu**.

### Penandaan (tagging) — `host-inventory.tsv`

Tiap host ditandai 3 dimensi: **hosting** · **fungsi** · **tier**.

**Fungsi** (dari prefix/keyword): `other 355 · offer 92 · affiliate 61 · tracker 19 · redirector 17 · verify 4`
**Tier**: `THROWAWAY 401 · CORE 128 · THROWAWAY-DGA 19` (domain kembar `<gibberish>.<gibberish>`)

### Daftar bertanda (siap pakai)

| File | Isi | # |
|---|---|---:|
| `hosts_LIVE_CORE.txt` | **HIDUP + CORE — prioritas takedown/pelacakan** | 67 |
| `hosts_LIVE_all.txt` | semua host hidup | 222 |
| `hosts_DGA_twins.txt` | domain kembar auto-generate | 19 |
| `hosts_DEAD.txt` | domain mati (rotasi) | 320 |

### Host INTI menonjol (LIVE + CORE)

- **Keluarga "verify" palsu:** `verifyhey.com`, `verifyho.com`, `verifykay.com`, `verifynio.com`, `verifyom.com`, `verifytotal.com`, `verify.211pr.com`, `secure.veloxworks.com` — halaman "verifikasi manusia" jebakan.
- **Redirector CPA:** `go.click-2-offer.com`, `redir.lucky-members.com`, `go.rew76.com`, `go.trknest.com`, `go.wflirt.com`, `go.gft23.com`.
- **Tracker:** `trk.ads-srv.net`, `zupertrakk.com`, `mediaflowtrack.com`, `trackfllighttour.com`, `clk.winknearby.com`.
- **Offer/monetisasi:** `free.gf920.com` (cloaker kasus ini), `aprizedaily.com`, `cloud-offers.com`, `offers-4u.com`, `winknearby.com`, `playzix.com`, `flyinmob.com`, `beatmobi.com`.

---

## 8. Kesimpulan Diperbarui

- Jaringan **jauh lebih besar & tersebar** dari kesan awal: **506 domain / 548 host**, **222 hidup** di **≥4 origin** (INAP Chicago primer + WorldStream NL + Namecheap PHX + alt). **320 domain sudah dibuang** → rotasi agresif.
- **"Kuota Gratis 81GB HUT RI" = 1 dari ratusan umpan** yang bermuara ke hub cloaking/CPA yang sama.
- **Prioritas aksi** = 67 host **LIVE+CORE** (`hosts_LIVE_CORE.txt`) + origin **INAP 108.178.23.116**, bukan mengejar 401 domain throwaway.
- Origin Hostinger Jakarta = shared hosting, **bukan** target.

*Snapshot 2026-08-18; jaringan dinamis — domain kembar & pointing IP dapat berganti kapan saja. Angka liveness berbasis resolve DNS + probe HTTP pada tanggal tsb.*
