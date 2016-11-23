server '192.168.199.194',
  user: fetch(:deploy_user),
  roles: %w{app db web},
  ssh_options: { forward_agent: true }
