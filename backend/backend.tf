terraform {
    backend "s3" {
    bucket= "backendbuck001"
    key = "terraform/tfstate.tfstate"
    region =  "eu-north-1"
    access_key = ""
    secret_key = ""

    }
}