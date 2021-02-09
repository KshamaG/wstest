data "ibm_space" "spacedata" {
  org   = var.organization
  name  = var.environment
}

data "ibm_app_domain_shared" "domain" {
  name = "mybluemix.net"
}

data "archive_file" "app" {
  type        = "zip"
  source_dir = "src"
  output_path = "app.zip"
}

resource "ibm_app_route" "approute-demo-001" {
  domain_guid = data.ibm_app_domain_shared.domain.id
  space_guid  = data.ibm_space.spacedata.id
  host        = "${var.app_name}-${var.environment}"
}

resource "ibm_app" "cf-demo-001" {
  name                 = var.app_name
  space_guid           = data.ibm_space.spacedata.id
  app_path             = "app.zip"
  buildpack            = "python_buildpack"
  route_guid           = [ibm_app_route.approute-demo-001.id]
  app_version          = "1"
  instances            = 2
  tags                 = [var.environment]
}

