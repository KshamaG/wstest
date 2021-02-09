data "ibm_space" "spacedata" {
  org   = var.organization
  name  = var.environment
}

data "ibm_app_domain_shared" "domain" {
  name = "mybluemix.net"
}

# data "archive_file" "app" {
#   type        = "zip"
#   source_dir = "src"
#   output_path = "app.zip"
# }

resource "null_resource" "prepare_app_zip" {
  triggers = {
    app_version = var.app_version
    git_repo    = var.git_repo
  }

  provisioner "local-exec" {
    command = <<EOF
        mkdir -p ${var.dir_to_clone}
        cd ${var.dir_to_clone}
        git clone ${var.git_repo}
        cd ${var.source_dir}
        zip -r ${var.app_zip} *
        
EOF

  }
}

resource "ibm_app_route" "approute-demo-001" {
  domain_guid = data.ibm_app_domain_shared.domain.id
  space_guid  = data.ibm_space.spacedata.id
  host        = "${var.app_name}-${var.environment}"
}

resource "ibm_app" "cf-demo-001" {
    depends_on = [
    null_resource.prepare_app_zip,
  ]
  name                 = var.app_name
  space_guid           = data.ibm_space.spacedata.id
  app_path             = var.app_zip
  buildpack            = "python_buildpack"
  route_guid           = [ibm_app_route.approute-demo-001.id]
  app_version          = "1"
  instances            = 2
  tags                 = [var.environment]
}

