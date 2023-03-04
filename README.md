Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

# Project Structure

```
├── README.md
├── analyses
├── dbt_packages
├── dbt_project.yml         # Existence of this file == A DBT project
│                           # This file defines various project configurations
├── logs
│   └── dbt.log
├── macros
├── models
│   ├── device_event.sql    # This file is called a model;
│   │                       # There should be a key called `device_event` under key `models` in
│   │                       # schema.yml
│   └── schema.yml          # This file should be under models/ dir
│                           # This files defines data source, tables, models, test on them etc.
├── profiles.yml            # By default, dbt expects the profiles.yml file to be located in the ~/.dbt/ directory.
│                           # This file stores different profiles of the project
│                           # basically, env configs;
│                           # It contains all the details required to connect to your data warehouse.
├── seeds
├── snapshots
├── target
│   ├── compiled
│   │   └── sample
│   │       └── models
│   │           └── schema.yml
│   ├── graph.gpickle
│   ├── manifest.json
│   ├── partial_parse.msgpack
│   ├── run
│   │   └── sample
│   │       └── models
│   │           └── schema.yml
│   └── run_results.json
└── tests
```

# Test

```bash
~/dbt-eg on  main! ⌚ 18:59:47
$  dbt test \
--profile bigquery \      # override profile set, if any, in dbt_project.yml
--target default \          # override target set, if any, in profile.yml 
# override vars set, if any, in dbt_project.yml
--vars "{source_iot_telemetry: iot_telemetry_dev, table_device: device, table_event: event}" \
--select device_event   # specify particular model to test
```

```bash
zsh: correct 'test' to 'tests' [nyae]? n
13:29:54  Running with dbt=1.4.4
13:29:54  Found 1 model, 4 tests, 0 snapshots, 0 analyses, 334 macros, 0 operations, 0 seed files, 2 sources, 0 exposures, 0 metrics
13:29:54
13:29:54  Nothing to do. Try checking your model configs and model specification args
```

# Run

```bash
(.venv)
~/dbt-eg on  main! ⌚ 18:59:47
$ dbt run \
--profile bigquery \
--vars "{source_iot_telemetry: iot_telemetry_dev, table_device: device, table_event: event}" \
--select device_event
```

```bash
13:44:44  Running with dbt=1.4.4
13:44:44  Found 1 model, 4 tests, 0 snapshots, 0 analyses, 334 macros, 0 operations, 0 seed files, 2 sources, 0 exposures, 0 metrics
13:44:44
13:44:49  Concurrency: 1 threads (target='staging')
13:44:49
13:44:49  1 of 1 START sql view model iot_telemetry_dev.device_event ..................... [RUN]
13:44:51  1 of 1 OK created sql view model iot_telemetry_dev.device_event ................ [CREATE VIEW (0 processed) in 1.94s]
13:44:51
13:44:51  Finished running 1 view model in 0 hours 0 minutes and 7.23 seconds (7.23s).
13:44:51
13:44:51  Completed successfully
13:44:51
13:44:51  Done. PASS=1 WARN=0 ERROR=0 SKIP=0 TOTAL=1
```

Run model `device_event_fast` and it's upstream dependencies

```bash
(.venv)
~/dbt-eg on  main! ⌚ 18:59:47
$ dbt run \
--profile bigquery \
--target default \ # this time being explicit, just for verbose
--vars "{source_iot_telemetry: iot_telemetry_dev, table_device: device, table_event: event}" \
--select "+device_event_fast"
```


# DBT Basics

## DBT Primitives

- resources
    - models
    - snapshots
    - seeds
    - tests

### Source

https://docs.getdbt.com/docs/build/sources

### Model

- Incremental models
    - https://docs.getdbt.com/docs/build/incremental-models

### Config & Property

- https://docs.getdbt.com/reference/configs-and-properties
- https://docs.getdbt.com/reference/global-configs
- https://docs.getdbt.com/reference/dbt_project.yml
- https://docs.getdbt.com/reference/model-configs
- https://docs.getdbt.com/reference/resource-configs/bigquery-configs

- configs
    - dbt_project.yml
    -
- properties
    - source
    - macro

### Seed

### Analysis

https://docs.getdbt.com/docs/build/analyses

### Package

In DBT, libraries (to install) are called packages.

https://docs.getdbt.com/docs/build/packages

- Hub
- Git
- Private
- Local

### Test

https://docs.getdbt.com/docs/build/tests

- Singular test
    - https://docs.getdbt.com/docs/build/tests#singular-tests
- Generic tests
    - https://docs.getdbt.com/docs/build/tests#generic-tests
- Open-Sourced Custom tests
    - https://github.com/dbt-labs/dbt-utils/tree/0.2.4/#schema-tests
- Custom tests

- Store test failures in table
    - https://docs.getdbt.com/docs/build/tests#storing-test-failures

### Snapshot

### Macro

### Profile

- https://docs.getdbt.com/docs/get-started/connection-profiles
- https://docs.getdbt.com/reference/profiles.yml

### Target

## DBT CLI Syntax

- Node selection
    - https://docs.getdbt.com/reference/node-selection/syntax
    - Model selection
        - https://towardsdatascience.com/dbt-cli-model-selection-52ddd038d8b2

# Deployment

https://docs.getdbt.com/docs/deploy/deployments


- DBT Cloud
- Airflow
    - https://docs.getdbt.com/blog/dbt-airflow-spiritual-alignment
- Perfect
- Dagster
- CI/Jenkins
- Cron

# FAQs

1. `;` at the end of SQL statement is not accepted in `<model>.sql` files
1. `dbt_project` model config is namespaced by `project` name, and then by directory (NOT package) names (optionally)
1. `profile` naming convention could be per warehouse - that suits better
    1. Under which, `targets` could be different environment of the warehouse
1. How to modularize code?
    1. Just use (sub) directories, there is no concept of package - same as Go/Python
    1. The files name within dir `models` should be unique. Otherwise it will raise Compilation error.
1. How to import accross modularized [models defined within (sub) directories]
    1. As model name should be unique through-out the project, use `ref("<model name>")` to reference a model.
1. How to run/test a model along with its dependent models as well?
    1. Refer `model selection` CLI syntax
    1. You can use upstream (prefix model name with `+`) syntax
1. What's difference between `config` and `property`?
    1. Property
        1. It describes/defines the resource and their structure
        1. Any `.yml` file under any `resource` (models, seeds, analyses, snapshots etc.) directory is called a property file
    1. Config
        1. `config` are special type of property, that changes the configurations of operations on the resources (e.g. how to materialize)
        1. `config` could be defined:
            1. As `config` macro within `.sql` file
            1. As `config` key/node within any `.yml` property file
            1. As `<resource_name>` key/node within `dbt_project.yml` file
 

# TODO

- How to parition/cluster bigquery models using config/property


# References
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
