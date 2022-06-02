resource "azurerm_resource_group" "rg_functionapp_linux_new" {
  name     = "rg-functionapp-linux-new"
  location = "Eastus2"
}

resource "azurerm_storage_account" "sa_new" {
  name                     = "safuncwinnew01"
  resource_group_name      = azurerm_resource_group.rg_functionapp_linux_new.name
  location                 = azurerm_resource_group.rg_functionapp_linux_new.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "asp_functionapp_linux_new" {
  name                = "asp-functionapp-linux-new"
  resource_group_name = azurerm_resource_group.rg_functionapp_linux_new.name
  location            = azurerm_resource_group.rg_functionapp_linux_new.location
  # reserved            = true 
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_windows_function_app" "functionapp_linux_new" {
  name                = "functionapp-linux-new-01"
  location            = azurerm_resource_group.rg_functionapp_linux_new.location
  resource_group_name = azurerm_resource_group.rg_functionapp_linux_new.name
  service_plan_id      = azurerm_service_plan.asp_functionapp_linux_new.id
  storage_account_name = azurerm_storage_account.sa_new.name
  
  # Optional
  # storage_account_access_key = azurerm_storage_account.sa_new.primary_access_key
    
  # Required
  site_config {}
}