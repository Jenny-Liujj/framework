# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'framework'
set :repo_url, 'git@github.com:liu7899/framework.git'
set :deploy_user, 'ssgene-forum'
set :deploy_to, '/home/ssgene-forum/www/framework'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :pty, true
set :linked_files, fetch(:linked_files, []).push('config/database.yml',
                                                 'config/secrets.yml',
                                                 'config/settings.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache',
                                               'tmp/sockets', 'public/system')

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

end
