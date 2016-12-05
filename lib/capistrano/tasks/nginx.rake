namespace :nginx do
  nginx_root = '/opt/nginx'

  desc 'Configure nginx.'
  task :conf do
    on roles(:app) do |server|
      nginx_conf = "#{nginx_root}/conf/nginx.conf"
      if test("[ ! -d #{nginx_root} ]")
        error "#{server} does not install nginx (from passenger) in #{nginx_root}!"
      end
      sites_available = "#{nginx_root}/conf/sites-available"
      sites_enabled = "#{nginx_root}/conf/sites-enabled"
      if test("[ ! -d #{sites_available} ]")
        sudo "mkdir -p #{sites_available}"
        sudo "mkdir -p #{sites_enabled}"
      end
      site_conf = "#{sites_available}/#{fetch(:application)}.conf"
      if test("[ ! -f #{site_conf} ]")
        system "scp config/nginx.conf root@#{server}:#{site_conf}"
        sudo "ln -s #{site_conf} #{sites_enabled}"
      end
      if test("! grep '#{sites_enabled}' #{nginx_root}/conf/nginx.conf")
        sudo "awk '{new=$0; print old; old=new}END{print \"include #{sites_enabled}/*.conf;\"; print old}' #{nginx_conf} > tmp"
        sudo "mv -f tmp #{nginx_conf}"
      end
    end
  end

  desc 'Start nginx.'
  task :start do
    on roles(:web) do
      sudo "#{nginx_root}/sbin/nginx"
    end
  end

  desc 'Stop nginx.'
  task :stop do
    on roles(:web) do
      sudo "#{nginx_root}/sbin/nginx -s stop"
    end
  end

  desc 'Restart nginx.'
  task :restart do
    on roles(:web) do
      sudo "#{nginx_root}/sbin/nginx -s stop"
      sudo "#{nginx_root}/sbin/nginx"
    end
  end
end
