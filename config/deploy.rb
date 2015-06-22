lock '3.3.5'
set :application, 'harmless_coding_tips'
set :repo_url, "git@github.com:chrislerum/harmless_coding_tips.git"
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :deploy_to, '/home/deploy/sites/harmless_coding_tips'
set :chruby_ruby, '2.2.0'
# set :scm, :git
# set :format, :pretty
# set :log_level, :debug
# set :pty, true
# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
#set :default_env, { path: "/opt/ruby/bin:$PATH" }

# set :keep_releases, 5

namespace :db do
  #task :setup, :except => {:no_release => true} do
    #run "mkdir -p #{shared_path}/config"
    #run "mkdir -p #{shared_path}/public/uploads"
    #run "mkdir -p #{shared_path}/public/wordpress"
  #end

  #task :symlink, :except=> {:no_release => true} do
    #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    #run "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
    #run "ln -nfs #{shared_path}/public/wordpress #{release_path}/public/blog"
  #end
end

namespace :deploy do

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

Rake::Task['deploy:assets:backup_manifest'].clear_actions
namespace :deploy do
  namespace :assets do
    task :backup_manifest do
      on roles(fetch(:assets_roles)) do
        within release_path do
          execute :cp,
                  release_path.join('public', fetch(:assets_prefix), '.sprockets-manifest*'),
                  release_path.join('assets_manifest_backup')
        end
      end
    end
  end
end
end
