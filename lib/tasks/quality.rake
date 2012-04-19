# Colors
escape  = -> n { STDOUT.tty? ? "\033[#{n}m" : "" }
red     = escape[31]
green   = escape[32]
yellow  = escape[33]
blue    = escape[34]
magenta = escape[35]
cyan    = escape[36]
reset   = escape[ 0]

desc "Runs reek and cane."
task :quality do
  puts yellow + "Cane " + "=" * 10 + reset
  puts `cane --style-glob="{app,lib}/**/*.rb" --no-doc`

  # Because reek's output isn't the nicest.
  puts yellow + "Reek " + "=" * 10 + reset

  rbfiles = Dir.glob("{app,lib}/**/*.rb").join(" ")
  reek    = `reek -q #{rbfiles} 2>&1`.split(/\r|\n/).reject(&:empty?)

  reek.select! do |line|
    line.index("warning") || line.index("UncommunicativeVariableName") || line.index("TooManyStatements")
  end

  reek_files = {}
  file = nil
  reek.each do |line|
    this_line_is_warning = !line.start_with?("  ") && line.index("warning")
    file = line.gsub(/ --.*/, '') if this_line_is_warning

    unless file.nil? || this_line_is_warning
      (reek_files[file] ||= []) << line
    end
  end

  reek = []
  reek_files.keys.each do |file|
    reek << ""
    reek << green + file + reset
    reek_files[file].each do |problem|
      problem = problem.gsub(/  [^ ]+/) { |s| blue + s + reset }
      reek << problem
    end
  end

  reek = reek.drop(1)

  puts reek
end
