# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  environment     = "${var.environment}"
}

resource "azurerm_resource_group" "test" {
  name     = "rhel-vm"
  location = "usgovvirginia"
}


resource "azurerm_template_deployment" "app" {
  name                = "rhelvmtemplate"
  resource_group_name = "${azurerm_resource_group.test.name}"

  template_body = "${file("./azuredeploy.json")}"

  deployment_mode = "Incremental"

  parameters = {
    adminUserName  = "${var.adminUserName}"
    adminPassword  = "${var.adminPassword}"
    vmName         = "${var.vmName}"
  }
}