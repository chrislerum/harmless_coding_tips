directories %w(app config spec)

clearing :on

guard :rspec, cmd: "bin/spring rspec", all_on_start: true, all_after_pass: true do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  rails = dsl.rails(view_extensions: %w(slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) { 'spec' }

  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }
  watch(rails.view_dirs)     { |m| "#{rspec.spec_dir}/features" }
  watch(/^spec\/factories\/.+\.rb/)     { 'spec' }
end
