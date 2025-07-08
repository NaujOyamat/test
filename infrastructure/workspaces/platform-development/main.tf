locals {
  app_version = "v1.3.2 "
}

data "terraform_remote_state" "shared_services" {
  backend = "remote"

  config = {
    organization = "confio"
    workspaces = {
      name = "shared-services"
    }
  }
}

module "google_platform_project" {
  source = "../../modules/google-platform-project"

  env                               = "development"
  folder_id                         = data.terraform_remote_state.shared_services.outputs.google_platform_folder
  billing_account                   = data.terraform_remote_state.shared_services.outputs.google_billing_account
  app_version                       = local.app_version
  continous_integration_agent_email = data.terraform_remote_state.shared_services.outputs.continous_integration_agent_email
  domain_checkout                   = "checkout.dev.confiopagos.com"
  domain_api                        = "api.dev.confiopagos.com"
  domain_app                        = "app.dev.confiopagos.com"
  domain_admin                      = "admin.dev.confiopagos.com"
  payments_way_base_url             = "https://serviceregisterpruebas.vepay.com.co"
  payments_way_terminal_id          = "418"
  payments_way_form_id              = "409"
  recaptcha_allowed_domains         = ["app.dev.confiopagos.com", "localhost"]
}
