local secrets = require 'secrets'

require('github-notifications').setup {
  username = secrets.username,
  token = secrets.token,
}
