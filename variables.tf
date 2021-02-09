variable "ibmcloud_api_key" {
    default = ""
    description = "Requerido para crear componentes"
}
variable "organization" {
    default = ""
    description = "Nombre de la organización cloud foundry"
}
variable "environment" {
    default = ""
    description = "Nombre de su espacio de cloud foundry"
}
variable "app_version" {
  default = "1"
}
variable "git_repo" {
    default = "https://github.com/KshamaG/wstest.git"
}
variable "source_dir" {
    default = "wstest/src"
}
variable "dir_to_clone" {
  default = "/tmp/app_cf_code"
}
variable "app_zip" {
  default = "/tmp/app.zip"
}
variable "app_name" {
  default = "cf-demo-001-789"
}