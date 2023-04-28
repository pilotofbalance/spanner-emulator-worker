#!/bin/bash

gcloud config configurations create emulator &&
gcloud config set auth/disable_credentials true &&
gcloud config set project $PROJECT_ID &&
gcloud config set api_endpoint_overrides/spanner $SPANNER_EMULATOR_URL &&
gcloud config set auth/disable_credentials true &&
gcloud spanner instances create $INSTANCE_NAME --config=emulator-config --description=Emulator --nodes=1
gcloud spanner databases create $DATABASE_NAME --instance=$INSTANCE_NAME

gcloud spanner databases ddl update $DATABASE_NAME --instance=$INSTANCE_NAME --ddl="CREATE TABLE $TABLE_NAME (
  accession_number STRING(64) NOT NULL,
  accession_number_issuer_gid STRING(64) NOT NULL,
  org_unit_gid STRING(64) NOT NULL,
  report_gid STRING(64) NOT NULL,
  assistant_author_firstname STRING(64),
  assistant_author_id STRING(64),
  assistant_author_id_issuer_gid STRING(64),
  assistant_author_lastname STRING(64),
  assistant_author_secondname STRING(64),
  binary_content BYTES(MAX),
  compressed BOOL,
  content STRING(MAX),
  content_location STRING(MAX),
  format STRING(64),
  principal_author_firstname STRING(64),
  principal_author_id STRING(64),
  principal_author_id_issuer_gid STRING(64),
  principal_author_lastname STRING(64),
  principal_author_secondname STRING(64),
  report_time_timezone STRING(64),
  report_time_utc TIMESTAMP,
  status STRING(64),
  title STRING(64),
) PRIMARY KEY(accession_number, accession_number_issuer_gid, org_unit_gid, report_gid);"
