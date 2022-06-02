resource "azurerm_resource_group" "rg_appservice_windows_new" {
  name     = "new-rg-appservice-windows"
  location = "Eastus2"
}

resource "azurerm_service_plan" "asp_windows_new" {
  name                = "asp-windows-new"
  resource_group_name = azurerm_resource_group.rg_appservice_windows_new.name
  location            = azurerm_resource_group.rg_appservice_windows_new.location
  os_type             = "Windows"
  sku_name            = "B1"
  worker_count        = 1
}

resource "azurerm_windows_web_app" "as_windows_new" {
  name                = "as-windows-new-01"
  resource_group_name = azurerm_resource_group.rg_appservice_windows_new.name
  location            = azurerm_resource_group.rg_appservice_windows_new.location
  service_plan_id     = azurerm_service_plan.asp_windows_new.id

  site_config {
    always_on = true
    
    application_stack {
      dotnet_version = "v4.0"
    }
  }
}
