# Henry Hub Research | Natural Gas Research Lab

Independent research into the U.S. natural gas market, combining energy fundamentals, meteorology, quantitative analysis, industrial fuel economics and data engineering.

The objective is to make the drivers of Henry Hub pricing understandable through interactive tools, transparent methods and reproducible evidence.

**[Explore the research portfolio](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/) · [Data status](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/api/status.html) · [Technical documentation](lab/README.md)**

## Selected research projects

| Project | Research question | Explore |
| :--- | :--- | :--- |
| **Henry Hub Storage Forecaster** | How much does observed weather improve a seasonal estimate of weekly Lower 48 storage changes? | [Dashboard](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/storage/) · [Model](lab/storage/model.py) |
| **Natural Gas Weather Revision Monitor** | How do revisions between GFS forecast runs change expected heating and cooling exposure across the United States? | [Dashboard](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/weather/) · [Methodology](lab/weather/README.md) |
| **Industrial Gas Cost Simulator** | How does fixing a portion of fuel consumption affect an illustrative plant's winter energy budget? | [Simulator](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/industrial/) · [Calculation model](lab/industrial/model.js) |
| **Henry Hub Futures Curve Explorer** | How does the market reprice individual delivery months, seasonal premiums and calendar spreads? | [Explorer](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/) · [Application source](index.html) |
| **Natural Gas Data API** | How can storage, weather and spot prices be aligned in a reusable research dataset? | [API explorer](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/api/) · [Documentation](lab/api/README.md) · [Example notebook](lab/api/natural_gas_api.ipynb) |

## Featured research: storage and weather

**Historical research snapshot — 23 November 2026**

A chronological historical replay compares a five-year seasonal median of weekly storage changes with a model that adjusts for observed heating and cooling degree days. The model fits previous observations and predicts subsequent weeks without training on their outcomes.

| Metric | Seasonal median | Weather-adjusted model |
| :--- | ---: | ---: |
| Mean absolute error | 30.50 Bcf | 20.50 Bcf |
| Evaluation weeks | 463 | 463 |
| Evaluation period | 2018–2026 | 2018–2026 |

The recorded historical replay shows an approximately **32.8% reduction in mean absolute error**. This is a retrospective result using current-vintage historical observations, not a verified live forecasting track record. At this snapshot, no completed live forecasts had been scored. Historical data may have been revised, and first-release availability has not been established for every historical observation.

[Explore the storage dashboard](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/storage/) · [Replay results](lab/storage/backtest.csv) · [Forecast ledger](lab/storage/ledger/) · [Recorded metrics](lab/storage/state.json)

## Data and methodology

Coverage in the 23 November 2026 API snapshot:

| Dataset | Earliest observation | Records |
| :--- | :--- | ---: |
| EIA Lower 48 weekly storage | January 2010 | 881 |
| NOAA weekly population-weighted HDD/CDD | January 1981 | 2,394 |
| EIA Henry Hub daily spot quotes | January 1997 | 5,732 |

The shared pipeline records source URLs, retrieval times, coverage, units and data hashes. The API aligns weather and spot observations with storage reference weeks while preserving missing values. The weather monitor separately compares archived GFS forecasts across matching valid dates.

**Primary sources:** [EIA](https://www.eia.gov/naturalgas/), [NOAA Climate Prediction Center](https://www.cpc.ncep.noaa.gov/products/analysis_monitoring/cdus/degree_days/), [NOAA GFS archive](https://registry.opendata.aws/noaa-gfs-bdp-pds/), and the [U.S. Census Bureau](https://www.census.gov/). Selected longer futures-curve snapshots are reconstructed from SEC filings; the curve explorer identifies the distinct coverage and limitations of each archive.

See the [data dictionary and provenance notes](lab/data/README.md), [source manifest](lab/data/manifest.json), and [API metadata](lab/api/v1/index.json) for details and updated coverage.

## Research workflow

- Acquire and validate public energy and weather observations.
- Preserve units, reference dates, source provenance and missing-data conventions.
- Compare models with simple benchmarks and separate historical replay from live forecast evaluation.
- Present results in interactive, browser-based research tools.
- Publish refreshed datasets, tests and forecast records through [GitHub Actions](.github/workflows/refresh.yml).

## Reproduce and explore

The checked-in data snapshots allow local exploration without refreshing the sources. From the repository root:

```bash
python -m http.server 8000
```

Open `http://localhost:8000/lab/` in a browser.

To rebuild the core datasets and run their validation checks, follow the [reproduction instructions](lab/README.md). The GFS archive builder has separate GDAL requirements described in its [research notes](lab/weather/README.md).

**Technology:** Python, NumPy, JavaScript, HTML/CSS, JSON, CSV, Jupyter and GitHub Actions.

## About the research

This portfolio focuses on the relationship between physical natural gas fundamentals and market pricing, with an emphasis on transparent analysis and practical applications for independent researchers, market participants and industrial energy users.

The projects are research and educational tools, not investment advice. Model estimates, historical simulations and illustrative procurement scenarios are not guarantees of future performance. Third-party data remain subject to their source terms. No repository-wide open-source license is currently declared.
