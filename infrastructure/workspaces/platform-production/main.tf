locals {
  app_version = "v1.3.2"
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

  env                               = "production"
  folder_id                         = data.terraform_remote_state.shared_services.outputs.google_platform_folder
  billing_account                   = data.terraform_remote_state.shared_services.outputs.google_billing_account
  app_version                       = local.app_version
  continous_integration_agent_email = data.terraform_remote_state.shared_services.outputs.continous_integration_agent_email
  domain_checkout                   = "checkout.confiopagos.com"
  domain_api                        = "api.confiopagos.com"
  domain_app                        = "app.confiopagos.com"
  domain_admin                      = "admin.confiopagos.com"
  payments_way_base_url             = "https://serviceregister.paymentsway.co"
  payments_way_terminal_id          = "1929"
  payments_way_form_id              = "2691"
  recaptcha_allowed_domains         = ["app.confiopagos.com"]
}
