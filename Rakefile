
desc 'Assets precompile'
task "assets:precompile" do
  Rake::Task.clear
  nanocRakefile = File.join(File.dirname(__FILE__), 'nanoc', 'Rakefile')
  load nanocRakefile
  dir = nanocRakefile.pathmap("%d")
  Dir.chdir(dir) do
    Rake::Task[:compile].invoke()
  end
end
