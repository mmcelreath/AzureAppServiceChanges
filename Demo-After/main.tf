resource "azurerm_resource_group" "rg_appservice_linux_demo" {
  name     = "rg-appservice-linux-demo"
  location = "Eastus2"
}

resource "azurerm_app_service_plan" "asp_linux_demo" {
  name                = "asp-linux-demo"
  location            = azurerm_resource_group.rg_appservice_linux_demo.location
  resource_group_name = azurerm_resource_group.rg_appservice_linux_demo.name
  reserved            = true
  kind                = "linux"

  sku {
    tier     = "Basic"
    size     = "B1"
    capacity = 1
  }
}

resource "azurerm_linux_web_app" "new_web_app" {
  name                = "as-linux-demo-01"
  location            = azurerm_resource_group.rg_appservice_linux_demo.location
  resource_group_name = azurerm_resource_group.rg_appservice_linux_demo.name
  service_plan_id     = azurerm_app_service_plan.asp_linux_demo.id

  site_config {
    always_on = true

    application_stack {
      docker_image     = "appsvcsample/python-helloworld"
      docker_image_tag = "latest"
    }
  }
}


