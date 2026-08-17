# 🔗 OSINT Sources & References

Semua tautan sumber untuk verifikasi independen atas [`FINDINGS.md`](FINDINGS.md) dan
[`DIGITAL-TRACES-DOSSIER.md`](DIGITAL-TRACES-DOSSIER.md). Dikumpulkan 2026-08-18.

---

## 📰 Konfirmasi otoritas & media (kampanye "Kuota Gratis 81GB HUT RI ke-81")

- **Akurat.co** — Kuota Gratis 81 GB HUT ke-81 RI viral di WhatsApp, ini faktanya
  <https://www.akurat.co/viral/882736/kuota-gratis-81-gb-hut-ke-81-ri-viral-di-whatsapp-ini-faktanya>
- **Tribun Kaltim** — Waspada Hoaks, link palsu bisa curi data pribadi
  <https://kaltim.tribunnews.com/news/1161767/waspada-hoaks-kuota-gratis-81-gb-hut-ke-81-ri-2026-link-palsu-bisa-curi-data-pribadi>
- **Tribun Priangan** — Waspada Hoaks pendaftaran pembagian kuota 81 GB
  <https://priangan.tribunnews.com/nasional/89485/waspada-hoaks-pendaftaran-pembagian-kuota-data-gratis-81-gb-di-momen-hut-ke-81-ri-2026>
- **RRI.co.id** — Hoaks tautan pulsa dan kuota gratis HUT ke-81 RI
  <https://rri.co.id/banjarmasin/cek-fakta/2177862/hoaks-tautan-pulsa-dan-kuota-gratis-hut-ke-81-ri>
- **Pikiran Rakyat (Jateng)** — Awas Phishing Kuota Gratis HUT RI, WhatsApp bisa dibajak
  <https://jateng.pikiran-rakyat.com/gaya-hidup/pr-37310397446/awas-phishing-kuota-gratis-hut-ri-whatsapp-bisa-dibajak>
- **Dialeksis** — Dosen Ilmu Komputer ingatkan modus phishing di WhatsApp
  <https://dialeksis.com/nasional/waspada-pesan-kuota-gratis-81-gb-dosen-ilmu-komputer-ingatkan-modus-phishing-di-whatsapp/>
- **Janalokajournal** — Kemenkomdigi tegaskan kabar hoaks
  <https://janalokajournal.id/hoaks-kuota-gratis-81-gb-spesial-hut-ri/>
- **NETIZ.ID** — Dipastikan penipuan
  <https://netiz.id/ekobis/baca/waspada-kuota-gratis-81-gb-hut-ri-ke-81-dipastikan-penipuan/>
- **Terkini24** — Hoaks Kuota Gratis 81 GB spesial kemerdekaan
  <https://terkini24.id/hoaks-kuota-gratis-81-gb-spesial-kemerdekaan/>
- **Ladokutu News** — Waspada pesan berantai dipastikan hoaks & penipuan
  <https://www.ladokutunews.id/2026/08/waspada-pesan-berantai-kuota-gratis-81.html>

## 🧪 Render langsung / sandbox (bukti independen)

- urlscan #1 landing — <https://urlscan.io/result/01a01152-4886-778c-85cb-239aff0aa3bc/>
- urlscan #2 go.php→srvmediahost→obqj3 — <https://urlscan.io/result/01a01156-fd3d-719e-b164-551fa2162c28/>
- urlscan #3 cloaker→ldl1 — <https://urlscan.io/result/01a01152-4da8-742f-9115-4b876c71bffd/>
- urlscan #4 mms.sramms.space→ldl1 — <https://urlscan.io/result/01a01157-0141-772e-871d-1cdeb0c80765/>
- urlscan #5 ldl1 — <https://urlscan.io/result/01a01157-04c6-7159-b314-4764f30466fb/>

## 🕰️ Arsip (Internet Archive / Wayback)

- gf920.com **2018** (situs judi 和信娱乐城) — <https://web.archive.org/web/20180805121500/http://gf920.com/>
- gf920.com CDX (semua snapshot) — <http://web.archive.org/cdx/search/cdx?url=gf920.com*&output=text>
- 16gift.com **2012** (toko hadiah, CDX) — <http://web.archive.org/cdx/search/cdx?url=16gift.com*&output=text>

## 🧭 Passive DNS / reputasi (per aset — ganti domain/IP sesuai IOC)

- OTX AlienVault — IP: <https://otx.alienvault.com/indicator/ip/108.178.23.116> · <https://otx.alienvault.com/indicator/ip/95.217.42.163>
- OTX AlienVault — domain: <https://otx.alienvault.com/indicator/domain/gf920.com>
- VirusTotal (GUI) — <https://www.virustotal.com/gui/domain/gf920.com> · <https://www.virustotal.com/gui/domain/16gift.com> · <https://www.virustotal.com/gui/domain/sramms.space> · <https://www.virustotal.com/gui/domain/srvmediahost.com>
- VirusTotal — IP: <https://www.virustotal.com/gui/ip-address/108.178.23.116> · <https://www.virustotal.com/gui/ip-address/95.217.42.163>
- ipinfo — <https://ipinfo.io/108.178.23.116> · <https://ipinfo.io/95.217.42.163> · <https://ipinfo.io/104.219.250.37>
- Certificate Transparency (crt.sh) — <https://crt.sh/?q=obqj3.com> · <https://crt.sh/?q=sramms.space> · <https://crt.sh/?q=gf920.com>

## 📚 Konteks riset (Cloaking-as-a-Service)

- Varonis — *1Campaign: A New Cloaking Platform* — <https://www.varonis.com/blog/1campaign>
- Varonis — *How Threat Actors Use AI to Hide Malicious Sites* — <https://www.varonis.com/blog/ai-hides-malicious-sites>
- Malwarebytes — *The great Google Ads heist* — <https://www.malwarebytes.com/blog/threat-intel/2025/01/the-great-google-ads-heist-criminals-ransack-advertiser-accounts-via-fake-google-ads>

## 🛠️ Alat & API (dipakai dalam investigasi, semuanya pasif)

- urlscan.io API — <https://urlscan.io/docs/api/>
- OTX AlienVault API — <https://otx.alienvault.com/api>
- HackerTarget reverse-IP — <https://hackertarget.com/reverse-ip-lookup/>
- RapidDNS same-IP — <https://rapiddns.io/>
- WHOIS/IANA — <https://www.iana.org/whois>
- Plausible Analytics (perangkat lunak yang disalahgunakan operator) — <https://plausible.io/>

## 🚨 Lapor / takedown (Indonesia)

- **Aduan Konten Kemenkomdigi** — <https://aduankonten.id/>
- **BSSN / CSIRT Indonesia** — <https://bssn.go.id/> · <https://csirt.go.id/>
- **Google Safe Browsing report** — <https://safebrowsing.google.com/safebrowsing/report_phish/>

---

*Tautan disediakan untuk verifikasi & pelaporan defensif. Konten era-2018 (QQ/WeChat/judi) adalah
lead OSINT historis dari arsip publik, bukan atribusi individu final.*
