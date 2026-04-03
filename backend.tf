terraform {
  backend "s3" {
    bucket      = "tf-state-lab3-kalushka-sofia-09"
    key         = "env/dev/var-09.tfstate"
    region      = "eu-central-1"
    encrypt     = true
    use_lockfile = true
  }
}
