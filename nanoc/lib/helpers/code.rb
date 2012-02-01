require 'systemu'

def code_highlight_style(style, prefix)
  cmd = [ 'pygmentize', '-S', style, '-f', 'html', '-a', prefix]

  # Run command
  stdout = StringIO.new
  systemu cmd, 'stdin' => '', 'stdout' => stdout

  # Get result
  stdout.rewind
  stdout.read
end
