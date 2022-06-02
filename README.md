# AzureAppServiceChanges

This Repository gives some examples of the changes to App Services, App Service Plans, and Function Apps in version 3.0+ of the AzureRM Terraform Provider.

The following resources have been deprecated in version 3.0 and will be removed in version 4.0:

- azurerm_app_service
- azurerm_function_app
- azurerm_app_service_plan

They are replaced by the following new resource types:

- azurerm_linux_web_app
- azurerm_windows_web_app
- azurerm_linux_function_app
- azurerm_windows_function_app
- azurerm_service_plan

# Example: Linux App

## azurerm_app_service (Deprecated)

```
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
    tier     = "Basic"
    size     = "B1"
    capacity = 1
  }
}

resource "azurerm_app_service" "as_linux_old" {
  name                = "as-linux-old-01"
  location            = azurerm_resource_group.rg_appservice_linux_old.location
  resource_group_name = azurerm_resource_group.rg_appservice_linux_old.name
  app_service_plan_id = azurerm_app_service_plan.asp_linux_old.id

  site_config {
    dotnet_framework_version = "v4.0"
    linux_fx_version         = "DOCKER|appsvcsample/python-helloworld:latest"

    always_on = true
  }
}
```

## azurerm_linux_web_app

```
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
```

# Example: Windows App

## azurerm_app_service (Deprecated)

```
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
    tier     = "Basic"
    size     = "B1"
    capacity = 1
  }
}

resource "azurerm_app_service" "as_windows_old" {
  name                = "as-windows-old"
  location            = azurerm_resource_group.rg_appservice_windows_old.location
  resource_group_name = azurerm_resource_group.rg_appservice_windows_old.name
  app_service_plan_id = azurerm_app_service_plan.asp_windows_old.id

  site_config {
    dotnet_framework_version = "v4.0"
    always_on = true
  }
}
```

## azurerm_windows_web_app

```
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
```

# Example: Linux Function App

## azurerm_function_app (Deprecated)

```
resource "azurerm_resource_group" "rg_functionapp_linux_old" {
  name     = "rg-functionapp-linux-old"
  location = "Eastus2"
}

resource "azurerm_storage_account" "sa_old" {
  name                     = "safunclinold01"
  resource_group_name      = azurerm_resource_group.rg_functionapp_linux_old.name
  location                 = azurerm_resource_group.rg_functionapp_linux_old.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "asp_functionapp_linux_old" {
  name                = "asp-functionapp-linux-old"
  location            = azurerm_resource_group.rg_functionapp_linux_old.location
  resource_group_name = azurerm_resource_group.rg_functionapp_linux_old.name
  reserved            = true
  kind                = "Linux"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_function_app" "functionapp_linux_old" {
  name                       = "functionapp-linux-old-01"
  location                   = azurerm_resource_group.rg_functionapp_linux_old.location
  resource_group_name        = azurerm_resource_group.rg_functionapp_linux_old.name
  app_service_plan_id        = azurerm_app_service_plan.asp_functionapp_linux_old.id
  storage_account_name       = azurerm_storage_account.sa_old.name
  storage_account_access_key = azurerm_storage_account.sa_old.primary_access_key

  site_config {
    always_on = true
  }
}
```

## azurerm_linux_function_app

```
resource "azurerm_resource_group" "rg_functionapp_linux_new" {
  name     = "rg-functionapp-linux-new"
  location = "Eastus2"
}

resource "azurerm_storage_account" "sa_new" {
  name                     = "safunclinnew01"
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
  os_type  = "Linux"
  sku_name = "B1"
}

resource "azurerm_linux_function_app" "functionapp_linux_new" {
  name                 = "functionapp-linux-new-01"
  location             = azurerm_resource_group.rg_functionapp_linux_new.location
  resource_group_name  = azurerm_resource_group.rg_functionapp_linux_new.name
  service_plan_id      = azurerm_service_plan.asp_functionapp_linux_new.id
  storage_account_name = azurerm_storage_account.sa_new.name

  # Optional
  # storage_account_access_key = azurerm_storage_account.sa_new.primary_access_key

  site_config {
    always_on = true
  }
}
```

# Example: Windows Function App

## azurerm_function_app (Deprecated)

```
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
```

## azurerm_windows_function_app

```
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
  name                 = "functionapp-windows-new-01"
  location             = azurerm_resource_group.rg_functionapp_windows_new.location
  resource_group_name  = azurerm_resource_group.rg_functionapp_windows_new.name
  service_plan_id      = azurerm_service_plan.asp_functionapp_windows_new.id
  storage_account_name = azurerm_storage_account.sa_new.name

  # Optional
  # storage_account_access_key = azurerm_storage_account.sa_new.primary_access_key

  # Required
  site_config {}
}
```