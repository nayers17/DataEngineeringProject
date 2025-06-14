#!/bin/bash
set -euo pipefail

airflow db upgrade                      # wait until schema is up‑to‑date

# create the admin user only once
if ! airflow users list | grep -q ' admin '; then
  airflow users create \
    --username "${AIRFLOW_DEFAULT_USER:-admin}" \
    --password "${AIRFLOW_DEFAULT_PASS:-admin}" \
    --firstname "${AIRFLOW_DEFAULT_FN:-Admin}" \
    --lastname  "${AIRFLOW_DEFAULT_LN:-User}" \
    --role Admin \
    --email "${AIRFLOW_DEFAULT_EMAIL:-admin@example.com}"
fi

exec airflow webserver