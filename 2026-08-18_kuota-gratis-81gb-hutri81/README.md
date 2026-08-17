# 🛡️ Forensic Case — "Kuota Gratis 81GB Spesial HUT RI ke-81"

> WhatsApp free-data **reward-bait scam** targeting Indonesian mobile users, funneling into a
> **multi-network CPA / ad-fraud** operation with a device-fingerprint cloaker — dissected
> end-to-end with passive, read-only techniques and full chain-of-custody.

![status](https://img.shields.io/badge/status-live%20at%20analysis-critical)
![type](https://img.shields.io/badge/type-phishing%20%2F%20CPA--fraud-orange)
![method](https://img.shields.io/badge/method-passive%20%2F%20read--only-blue)
![date](https://img.shields.io/badge/date-2026--08--18-informational)

| | |
|---|---|
| **Case ID** | `2026-08-18_kuota-gratis-81gb-hutri81` |
| **Trigger** | WhatsApp chain message received by a victim |
| **Initial URL** | `https://kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98` |
| **Verdict** | Viral share-to-unlock reward bait → CPA/ad-fraud smartlink funnel |
| **Official status** | Declared **HOAX** by Kemenkomdigi (Indonesia) |

---

## 📸 Preview

![Landing 81GB](screenshots/01_landing_merdeka_81gb.png)

*Full gallery → [`SCREENSHOTS.md`](SCREENSHOTS.md)*

---

## 🎯 TL;DR

A fake "Free 81GB quota for Indonesia's 81st Independence Day" WhatsApp lure. The landing page
shows a fake Facebook-style post with **fabricated social proof** and **forces the victim to
re-share on WhatsApp** before a "DAPATKAN 81GB" button routes them — via a `/go.php` redirector
and a **device-fingerprinting cloaker** (`free.gf920.com`) — into **rotating CPA ad networks**
(`ldl1.com` / `obqj3.com`). **No quota is ever delivered.** Monetization is traffic-arbitrage,
not credential theft; there is **no fixed APK and no exposed Telegram token** (the operator has
solid opsec). The same operator also runs a **Telegram Mini App "quiz" earn-to-payout scam**, and
the cloaker domain has a **2018 lineage as a Chinese online-gambling site**.

---

## 🔗 Attack Chain

```
WhatsApp message ─▶ kuota-gratis-81gb98.1grd.xyz/?hut-ri-81=98   (landing, Cloudflare Jakarta)
   │  fake social proof (626cdn.com) · telemetry (tj.16gift.com, self-hosted Plausible)
   ├─ SHARE GATE  whatsapp://send?text=…   (localStorage counter — forced propagation)
   ▼  /go.php?t=9
   free.gf920.com   [CLOAKER: Canvas/WebGL/Audio/font fingerprint + anti-bot] ── origin 108.178.23.116 (INAP)
   ▼  hex→ stage-2
   ┌ rotating RTB partners ─────────────────────────────────────────────┐
   │  A: mms.sramms.space → ldl1.com/link?z=…&var=27052                  │
   │  B: srvmediahost.com/nlp/…&url_bnm_redirect= → obqj3.com/link       │ ── origin 95.217.42.163 (Hetzner)
   └────────────────────────────────────────────────────────────────────┘
   ▼  offer served only to real Indonesian mobile IP + valid click (204 to datacenters)
```

---

## 🗺️ Infrastructure at a glance

| Layer | Key assets | Real origin (de-cloaked) |
|---|---|---|
| Bait | `1grd.xyz` (+wildcard), `626cdn.com`, `tj.16gift.com` | Cloudflare (hidden) |
| Cloaker | `free.gf920.com`, `srvmediahost.com` | **108.178.23.116** (INAP Chicago) · **95.217.42.163** (Hetzner Helsinki) |
| RTB / offer | `ldl1.com`, `obqj3.com`, `sramms.space` | Cloudflare / AWS CloudFront |
| Scale | **548 hosts / 506 domains** mapped, **222 live** across ≥4 origins | — |

De-cloaked origins, a 500+ domain network, Mandarin-operator attribution (registrars `west.cn` /
Hefei Juming; `tj`=统计 telemetry; 2018 gambling lineage `和信娱乐城`).

---

## 📂 Documents

| Document | Contents |
|---|---|
| **[`DIGITAL-TRACES-DOSSIER.md`](DIGITAL-TRACES-DOSSIER.md)** | Master consolidated report (chain, infra, attribution, IOC) |
| [`SCREENSHOTS.md`](SCREENSHOTS.md) | Visual evidence gallery |
| [`IOC.txt`](IOC.txt) | Indicators of compromise (6 network blocks) |
| [`report/DIGITAL-TRACES-DOSSIER.pdf`](report/) | Print-ready PDF (for Kominfo/BSSN & providers) |
| [`analysis/technical-analysis.md`](analysis/technical-analysis.md) | Cloaker/fingerprint internals, 6-hop chain |
| [`analysis/network-map.md`](analysis/network-map.md) | Full host map + liveness + tagging |
| [`analysis/deep-dive-round2.md`](analysis/deep-dive-round2.md) | Plausible analytics + Telegram Mini App product |
| [`analysis/attribution-and-osint.md`](analysis/attribution-and-osint.md) | 2018 gambling lineage, cross-links, external corroboration |
| [`analysis/payload-analysis.md`](analysis/payload-analysis.md) | Why no fixed APK / no Telegram token |
| [`analysis/urlscan-results.md`](analysis/urlscan-results.md) | 5 live browser renders |
| [`analysis/sandbox-submission.md`](analysis/sandbox-submission.md) | Safe capture procedure |
| [`analysis/abuse-reports/`](analysis/abuse-reports/) | Ready-to-send takedown drafts |

**Directory layout**
```
├── README.md · DIGITAL-TRACES-DOSSIER.md · SCREENSHOTS.md · IOC.txt
├── screenshots/     visual evidence (5)
├── report/          PDF export
├── analysis/        deep-dives, host inventory, abuse drafts
├── evidence/        raw captures + SHA256SUMS.txt (chain-of-custody) + urlscan/ + wayback/ + telegram-quiz/
└── tools/           safe, static-only helper scripts
```

---

## ✅ Method & Integrity

All interactions are **passive / read-only** — WHOIS, DNS, certificate transparency, OTX
passive-DNS, hackertarget reverse-IP, and sandboxed browser renders (urlscan.io). **No exploitation,
no active attacks, no data submitted to attacker infrastructure.** Every raw capture in
`evidence/` is hashed in `evidence/SHA256SUMS.txt` for independent verification.

## 🚨 Reporting

Ready-to-send drafts in [`analysis/abuse-reports/`](analysis/abuse-reports/): Cloudflare, Hetzner,
INAP, Namecheap, AWS, registrars, and **Kominfo/BSSN** (Indonesia).

## ⚖️ Disclaimer

Defensive security research, education, and abuse reporting only. The author is not affiliated with
any documented infrastructure. Indicators may go stale as attacker infrastructure rotates.
