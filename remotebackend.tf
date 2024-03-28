terraform {
  backend "azurerm" {
    storage_account_name = "remotestorage99"
    container_name       = "tfstate"
    key                  = "terraformpipe.tfstate"
    use_azuread_auth     = true
    access_key = "83maiPlkoCCM51/kb/lF8vxIhwhlmJ2XKGgLeBaqysVKxpyUParCZ3hSFlTkWppK27EiNKK50FtJ+AStxHYNdA=="
  }
}
