# Rake file for heroku

desc 'Assets precompile'
task "assets:precompile" do
  dir = File.join(File.dirname(__FILE__), 'nanoc')
  Dir.chdir(dir) do
    system('nanoc', 'compile')
  end
end
