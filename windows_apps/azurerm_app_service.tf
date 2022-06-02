resource "azurerm_resource_group" "rg_appservice_windows_old" {
  name     = "rg-appservice-windows-old"
  location = "Eastus2"
}

resource "azurerm_app_service_plan" "asp_windows_old" {
  name                = "asp-windows"
  location            = azurerm_resource_group.rg_appservice_windows_old.location
  resource_group_name = azurerm_resource_group.rg_appservice_windows_old.name
  kind                = "windows"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "as_windows_old" {
  name                = "as-windows-old"
  location            = azurerm_resource_group.rg_appservice_windows_old.location
  resource_group_name = azurerm_resource_group.rg_appservice_windows_old.name
  app_service_plan_id = azurerm_app_service_plan.asp_windows_old.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}