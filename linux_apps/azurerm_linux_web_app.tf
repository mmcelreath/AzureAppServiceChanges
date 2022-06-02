resource "azurerm_resource_group" "rg_appservice_linux_new" {
  name     = "rg-appservice-linux-new"
  location = "Eastus2"
}

resource "azurerm_service_plan" "asp_linux_new" {
  name                = "asp-linux-new"
  resource_group_name = azurerm_resource_group.rg_appservice_linux_new.name
  location            = azurerm_resource_group.rg_appservice_linux_new.location
  # reserved            = true
  os_type      = "Linux"
  sku_name     = "B1"
  worker_count = 1
}

resource "azurerm_linux_web_app" "as_linux_new" {
  name                = "as-linux-new-01"
  location            = azurerm_resource_group.rg_appservice_linux_new.location
  resource_group_name = azurerm_resource_group.rg_appservice_linux_new.name
  service_plan_id     = azurerm_service_plan.asp_linux_new.id

  site_config {
    always_on = true
    
    application_stack {
      docker_image     = "appsvcsample/python-helloworld"
      docker_image_tag = "latest"
      dotnet_version   = "6.0"
    }
  }
}
