terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "backet-rse"
    region     = "ru-central1"
    key        = ".terraform/terraform.tfstate"
    access_key = var.yc_sa_access_key
    secret_key = var.yc_sa_secret_key

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
