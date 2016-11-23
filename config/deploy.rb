# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'framework'
set :repo_url, 'git@github.com:liu7899/framework.git'
set :deploy_user, 'ssgene-forum'
set :deploy_to, '/var/www/framework'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :pty, true

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

end
