resource "azurerm_resource_group" "rg_functionapp_windows_new" {
  name     = "rg-functionapp-windows-new"
  location = "Eastus2"
}

resource "azurerm_storage_account" "sa_new" {
  name                     = "safuncwinnew01"
  resource_group_name      = azurerm_resource_group.rg_functionapp_windows_new.name
  location                 = azurerm_resource_group.rg_functionapp_windows_new.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "asp_functionapp_windows_new" {
  name                = "asp-functionapp-windows-new"
  resource_group_name = azurerm_resource_group.rg_functionapp_windows_new.name
  location            = azurerm_resource_group.rg_functionapp_windows_new.location
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_function_app" "functionapp_windows_new" {
  name                = "functionapp-windows-new-01"
  location            = azurerm_resource_group.rg_functionapp_windows_new.location
  resource_group_name = azurerm_resource_group.rg_functionapp_windows_new.name
  service_plan_id      = azurerm_service_plan.asp_functionapp_windows_new.id
  storage_account_name = azurerm_storage_account.sa_new.name
  
  # Optional
  # storage_account_access_key = azurerm_storage_account.sa_new.primary_access_key
    
  # Required
  site_config {}
}