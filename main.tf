provider "azurerm" {
  subscription_id = "be1a2020-bfb5-4835-a1a0-07a8dc045492"
  client_id       = "191bbad1-5fb7-42f4-98aa-013deb97819c"
  client_secret   = "d6e99a1b-9017-49e6-af9b-b9a0af9b1daa"
  tenant_id       = "6bc597a9-bd46-4b6c-bc74-3a1d94c69b61"
  features {}
}

# Configure the GitHub Provider
provider "github" {
  version = "~> 4.0"
  #token = var.token # or `GITHUB_TOKEN`
  token = "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"

}

data "template_file" "init" {
  template = "${file("${path.module}/template.tpl")}"
  vars = {
    environment_name = "usgovernment"
    name             = "ddp-avl-simulator-ui"
    version          = "0.1.1"
    location         = "usgovvirginia"
    environment      = "dev"
    customer         = "gov"
    image_version    = "develop"
    cloud            = "gov"
  }
}

resource "local_file" "foo" {
  content  = data.template_file.init.rendered
  filename = "${path.module}/ARCHIVO"
}

resource "github_branch" "branch" {
  repository = "proyectoGit"
  branch     = "feature/felipe_test"
  source_branch = "master"
  depends_on = [local_file.foo]

}

resource "github_repository_file" "file" {
  repository          = "proyectoGit"
  branch              = "feature/felipe_test"
  file                = "deploy/ARCHIVO"
  content             = data.template_file.init.rendered
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [github_branch.branch]
}

resource "github_repository_pull_request" "example" {
    base_repository = "proyectoGit"
    base_ref        = "master"
    head_ref        = "feature/felipe_test"
    title           = "My newest feature"
    body            = "This will change everything"
    depends_on = [github_repository_file.file]

}