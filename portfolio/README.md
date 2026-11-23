# Portfolio setup

The account display name should be **John Barreto**. Keep the login `NeuraX-JB` unchanged to preserve existing URLs.

The GitHub profile README belongs in a public repository named exactly `NeuraX-JB`. The [profile draft](profile-README.md) is intended to be copied into that repository's root README **after the six projects exist**.

## Separate project repositories

- `henry-hub-storage-forecaster` — Weather-adjusted U.S. natural gas storage nowcasts, chronological backtests and a timestamped forecast ledger.
- `natural-gas-weather-monitor` — Compare archived NOAA GFS forecast runs, regional HDD/CDD revisions and common valid dates.
- `henry-hub-futures-curve` — Analyze historical Henry Hub futures curves, delivery-month repricing, winter premiums and calendar spreads.
- `industrial-gas-cost-simulator` — Replay industrial winter gas costs and compare floating versus fixed-share procurement scenarios.
- `natural-gas-data-api` — Versioned static JSON endpoints for EIA storage, NOAA degree days and Henry Hub spot prices.
- `natural-gas-research-notes` — Independent natural gas market studies, documented findings, methods and research limitations.

The existing long-named public repository remains the canonical research website and scheduled data pipeline. The new repositories are project-specific source snapshots. They do not run competing publication workflows. The private NATGAS-REPORT repository is intentionally excluded.

## Optional one-time GitHub CLI setup (Windows PowerShell)

The [setup script](setup.ps1) creates the six public project repositories and the profile repository, with descriptions, project source files and prepared READMEs. It checks the signed-in GitHub account and skips repositories that already exist. It does not rename, delete, make private repositories public, or force-push any existing repository. Review the script before running it and confirm the terms for any third-party data you intend to republish.

1. Install Git and the GitHub CLI if not already installed. Run `gh auth login` and sign in as `NeuraX-JB`. Configure Git author name and email if needed.
2. Clone the original repository and run the reviewed `portfolio/setup.ps1` script in PowerShell.
3. Set the display name to John Barreto at [GitHub profile settings](https://github.com/settings/profile). The script deliberately does not change account settings.
4. Pin the six individual projects in the GitHub profile.

The source snapshots remain static until refreshed separately. Keep the canonical website as the primary maintained demo. Existing repositories are skipped, not synchronized. No script execution has been performed by the repository connector.
