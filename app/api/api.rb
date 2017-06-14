class API < Grape::API
  prefix 'api'
  version 'v1'
  format :json

  mount Endpoints::RekAuth
  mount Endpoints::RekUsers
  mount Endpoints::RekMedia
end