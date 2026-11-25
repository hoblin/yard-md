# frozen_string_literal: true

require "open3"

RSpec.shared_context "with the fixture project" do
  let(:root) { File.expand_path("../..", __dir__) }
  let(:load_path) { [File.join(root, "lib"), *Gem.loaded_specs["yard"].full_require_paths].map { |path| "-I#{path}" } }

  around do |example|
    Dir.mktmpdir do |dir|
      FileUtils.cp_r(Dir.glob(File.join(root, "spec/fixtures/*")), dir)
      @project = File.join(dir, "project")
      @home = dir
      example.run
    end
  end

  def run(executable, *args, chdir: @project, env: {"XDG_CACHE_HOME" => File.join(@home, "xdg")})
    Bundler.with_unbundled_env do
      Open3.capture3(env, RbConfig.ruby, *load_path, File.join(root, "exe", executable), *args, chdir: chdir)
    end
  end
end
