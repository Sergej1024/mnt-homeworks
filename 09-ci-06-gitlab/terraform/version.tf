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
    var.access_key = "YCAJEwQdANa_nagUkLZz6HmX8"
    var.secret_key = "YCO9N6WhuVCz0mCzRQRInrLR0IYq9gj4Cl1GdSA1"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
