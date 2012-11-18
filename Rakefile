# Rake file for heroku

desc 'Assets precompile'
task "assets:precompile" do
  ENV['DOT_COMMAND'] = ENV['HOME'] + '.graphviz/bin/dot'

  dir = File.join(File.dirname(__FILE__), 'nanoc')
  Dir.chdir(dir) do
    system('nanoc', 'compile')
  end
end
