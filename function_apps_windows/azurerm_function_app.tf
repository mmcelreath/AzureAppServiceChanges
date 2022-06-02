resource "azurerm_resource_group" "rg_functionapp_windows_old" {
  name     = "rg-functionapp-windows-old"
  location = "Eastus2"
}

resource "azurerm_storage_account" "sa_old" {
  name                     = "safuncwinold01"
  resource_group_name      = azurerm_resource_group.rg_functionapp_windows_old.name
  location                 = azurerm_resource_group.rg_functionapp_windows_old.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "asp_functionapp_windows_old" {
  name                = "asp-functionapp-windows-old"
  location            = azurerm_resource_group.rg_functionapp_windows_old.location
  resource_group_name = azurerm_resource_group.rg_functionapp_windows_old.name
  kind                = "Windows"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_function_app" "functionapp_windows_old" {
  name                       = "functionapp-windows-old-01"
  location                   = azurerm_resource_group.rg_functionapp_windows_old.location
  resource_group_name        = azurerm_resource_group.rg_functionapp_windows_old.name
  app_service_plan_id        = azurerm_app_service_plan.asp_functionapp_windows_old.id
  storage_account_name       = azurerm_storage_account.sa_old.name
  storage_account_access_key = azurerm_storage_account.sa_old.primary_access_key
}
