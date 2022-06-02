resource "azurerm_resource_group" "rg_appservice_linux_old" {
  name     = "rg-appservice-linux-old"
  location = "Eastus2"
}

resource "azurerm_app_service_plan" "asp_linux_old" {
  name                = "asp-linux-old"
  location            = azurerm_resource_group.rg_appservice_linux_old.location
  resource_group_name = azurerm_resource_group.rg_appservice_linux_old.name
  reserved            = true
  kind                = "linux"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "as_linux_old" {
  name                = "as-linux-old-01"
  location            = azurerm_resource_group.rg_appservice_linux_old.location
  resource_group_name = azurerm_resource_group.rg_appservice_linux_old.name
  app_service_plan_id = azurerm_app_service_plan.asp_linux_old.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    linux_fx_version         = "DOCKER|appsvcsample/python-helloworld:latest"
  }
}