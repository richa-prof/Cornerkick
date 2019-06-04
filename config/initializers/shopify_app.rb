ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "4274b67838ebc26bcbc9488cd6a67075"
  config.secret = "22fb3eb5632d36371e24152553b17741"
  config.old_secret = "<old_secret>"
  config.scope = "read_products" # Consult this page for more scope options:
                                 # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = "2019-04"
  config.session_repository = Shop
end
