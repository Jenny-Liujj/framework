namespace :pg do
  desc 'Initially create database.'
  task :create do
    on roles(:web) do
      execute("sudo -u postgres createdb #{fetch(:application)}_#{fetch(:stage)}", interaction_handler: {
        /password for #{fetch(:deploy_user)}:/ => "#{ENV['DEPLOY_USER_PASSWORD']}\n",
        /Password:/ => "#{ENV['DATABASE_ROLE_PASSWORD']}\n"
      })
    end
  end
end
