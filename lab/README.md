# Natural Gas Research Lab

Five interactive research projects for U.S. natural gas markets. [Open the public portfolio](https://neurax-jb.github.io/Henry-Hub-Futures-Curve-Explorer-How-the-Natural-Gas-Market-prices-winter/lab/).

| Project | What to try |
| --- | --- |
| [Henry Hub Storage Forecaster](./storage/index.html) | Inspect the next Lower 48 injection or withdrawal, its weather adjustment and prediction interval. Compare frozen, timestamped calls and a separate chronological replay with the five-year seasonal baseline. |
| [Natural Gas Weather Revision Monitor](./weather/index.html) | Select two archived GFS cycles, click a state and replay the daily changes in heating and cooling degree days across their common forecast dates. [Method and reproduction](./weather/README.md) |
| [Industrial Gas Cost Simulator](./industrial/index.html) | Replay a November–March winter for a U.S. plant. Edit monthly consumption, the percentage fixed, local basis and delivery charges, then export both budgets. Archived forward quotes and assumed quotes are labeled. |
| [Henry Hub Futures Curve Explorer](../index.html) | Compare two available dates by delivery month, inspect winter or March–April spreads and export prices. The four-contract EIA archive and the longer SEC-derived snapshots have distinct date coverage. |
| [Natural Gas Data API](./api/index.html) | Fetch joined weekly storage, observed weather and Henry Hub spot quotes in one [JSON request](./api/v1/weekly.json). [Status](./api/status.html) · [Example notebook](./api/natural_gas_api.ipynb) · [Endpoint documentation](./api/README.md) |

## Run locally

Serve the repository root with Python and open http://localhost:8000/lab/. Serving the root also makes the futures project available at its original address.

```sh
python -m http.server 8000
```

## Reproduce the data

From the repository root, run the following in order. The checked-in snapshots let visitors use the projects before running these commands. The refresh uses EIA and NOAA public endpoints and requires internet access.

```sh
python -m pip install xlrd==2.0.2 numpy
python lab/data/refresh.py
python lab/storage/refresh.py
python lab/api/build_api.py
python lab/industrial/refresh.py
```

Each published storage estimate has its own dated file in [the forecast ledger](./storage/ledger/). The walk-forward replay uses historical observations available in the current source files. Live accuracy requires a forecast that can be verified as publicly deployed before its corresponding first release. Data downloads, units, gaps and provenance are documented in [the source notes](./data/README.md). Instructions for reproducing the GFS archive, including its GDAL dependency, are in the [weather research notes](./weather/README.md).

## Checks

```sh
python -m unittest discover -s lab/data
python -m unittest discover -s lab/storage
python -m unittest discover -s lab/api
node --test lab/weather/research/weather.test.js lab/industrial/model.test.cjs
```
