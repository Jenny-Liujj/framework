namespace :setup do
  desc 'Upload private files to server.'
  task :upload_files do
    on roles(:app) do
      if test("[ ! -d #{shared_path}/config ]")
        sudo "mkdir -p #{shared_path}/config"
        sudo "chown -R #{fetch(:deploy_user)} #{fetch(:deploy_to)}"
      end
      fetch(:linked_files).each do |file|
        upload! file, "#{shared_path}/#{file}"
      end
    end
  end
end
