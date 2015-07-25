# group :tdd, halt_on_fail: true do
#   guard :rspec, cmd: "bundle exec rspec" do
#     require "guard/rspec/dsl"
#     dsl = Guard::RSpec::Dsl.new(self)
#
#     # RSpec files
#     rspec = dsl.rspec
#     watch(rspec.spec_helper) { rspec.spec_dir }
#     watch(rspec.spec_support) { rspec.spec_dir }
#     watch(rspec.spec_files)
#
#     # Ruby files
#     ruby = dsl.ruby
#     dsl.watch_spec_files_for(ruby.lib_files)
#
#     # Rails files
#     rails = dsl.rails(view_extensions: %w(erb haml slim))
#     dsl.watch_spec_files_for(rails.app_files)
#     dsl.watch_spec_files_for(rails.views)
#
#     watch(rails.controllers) do |m|
#       [
#         rspec.spec.("routing/#{m[1]}_routing"),
#         rspec.spec.("controllers/#{m[1]}_controller"),
#         rspec.spec.("acceptance/#{m[1]}")
#       ]
#     end
#
#     # Rails config changes
#     watch(rails.spec_helper)     { rspec.spec_dir }
#     watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
#     watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }
#
#     # Capybara features specs
#     watch(rails.view_dirs)     { |m| rspec.spec.("features/#{m[1]}") }
#     watch(rails.layouts)       { |m| rspec.spec.("features/#{m[1]}") }
#
#     # Turnip features and steps
#     watch(%r{^spec/acceptance/(.+)\.feature$})
#     watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
#       Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
#     end
#   end
#
#   guard :rubocop, all_on_start: false, cmd: "rubocop --require rubocop-rspec" do
#     watch(%r{.+\.rb$}) { |m| m[0] }
#     watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
#   end
# end

# interactor :off

guard :bundler do
  watch("Gemfile")
  watch(/^.+\.gemspec/)
end

watch_directives = Proc.new do
  require "ostruct"

  # Generic Ruby apps
  rspec = OpenStruct.new
  rspec.spec = ->(m) { "spec/#{m}_spec.rb" }
  rspec.spec_dir = "spec"
  rspec.spec_helper = "spec/spec_helper.rb"

  watch(%r{^spec/.+_spec\.rb$})
  # watch(%r{^lib/(.+)\.rb$})     { |m| rspec.spec.("lib/#{m[1]}") }
  watch(rspec.spec_helper)      { rspec.spec_dir }

  # Rails example
  rails = OpenStruct.new
  rails.app = %r{^app/(.+)\.rb$}
  rails.views_n_layouts = %r{^app/(.*)(\.erb|\.haml|\.slim)$}
  rails.controllers = %r{^app/controllers/(.+)_controller\.rb$}
  rails.routes = "config/routes.rb"
  rails.app_controller = "app/controllers/application_controller.rb"
  rails.spec_helper = "spec/rails_helper.rb"
  rails.spec_support = %r{^spec/support/(.+)\.rb$}
  rails.views = %r{^app/views/(.+)/.*\.(erb|haml|slim)$}

  watch(rails.app) { |m| rspec.spec.(m[1]) }
  watch(rails.views_n_layouts) { |m| rspec.spec.("#{m[1]}#{m[2]}") }
  watch(rails.controllers) do |m|
    [
      rspec.spec.("routing/#{m[1]}_routing"),
      rspec.spec.("controllers/#{m[1]}_controller"),
      rspec.spec.("acceptance/#{m[1]}")
    ]
  end

  watch(rails.spec_support)    { rspec.spec_dir }
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "spec/routing" }
  watch(rails.app_controller)  { "spec/controllers" }

  # Capybara features specs
  watch(rails.views)     { |m| rspec.spec.("features/#{m[1]}") }

end

# you can now add
# guard :rspec, cmd: "bundle exec rspec" do, &watch_directives
# and you'll only need to keep track of one set of directives
guard :zeus, cmd: "zeus rspec", &watch_directives

