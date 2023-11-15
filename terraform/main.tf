provider "google" {
  project = "helios-404801"
}

variable "region" {
    default = "us-east1"
}
variable "zone" {
    default = "us-east1-b"
}
resource "google_project_service" "bigquery" {
    service = "bigquery.googleapis.com"
}

resource "google_bigquery_dataset" "opticrop_dataset" {
    dataset_id                  = "opticrop"
    friendly_name               = "Determine optimal planting time of year for crops"
#   default_table_expiration_ms = 3600000 # 1 hour
}

resource "google_bigquery_table" "weekly_average_conditions" {
    dataset_id = google_bigquery_dataset.opticrop_dataset.dataset_id
    table_id   = "weekly_average_conditions"

    schema = <<EOF
    [
        {
            "name": "week_year",
            "type": "STRING",
            "mode": "NULLABLE"
        },
        {
            "name": "location",
            "type": "STRING",
            "mode": "NULLABLE"
        },
        {
            "name": "crop_name",
            "type": "STRING",
            "mode": "NULLABLE"
        },
        {
            "name": "avg_temperature",
            "type": "FLOAT64",
            "mode": "NULLABLE"
        },
        {
            "name": "avg_humidity",
            "type": "FLOAT64",
            "mode": "NULLABLE"
        },
        {
            "name": "growing_season_status",
            "type": "STRING",
            "mode": "NULLABLE"
        }
    ]
EOF
#   schema {
#     name = "week_year"
#     type = "STRING"
#   }

#   schema {
#     name = "location"
#     type = "STRING"
#   }

#   schema {
#     name = "crop_name"
#     type = "STRING"
#   }

#   schema {
#     name = "avg_temperature"
#     type = "FLOAT64"
#   }

#   schema {
#     name = "avg_humidity"
#     type = "FLOAT64"
#   }

#   schema {
#     name = "growing_season_status"
#     type = "STRING"
#   }
}