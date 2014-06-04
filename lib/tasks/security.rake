require 'brakeman'
require 'pry'

DEFAULT_MIN_CONFIDENCE = 2 # 0 is highest

def get_checks(params={})
  params[:min_confidence] = 2 unless params.has_key?(:min_confidence)
  tracker = Brakeman.run({
    app_path: '.',
    min_confidence: params[:min_confidence]
  })
  tracker.checks
end

def show_snippet(path, line_number, range=5)
  # WIP
  start = line_number - range
  finish = line_number + range
  # /Users/alandelevie/uscis/answers/app/views/guides/show.html.erb
  `head -#{start} #{path} | tail -#{finish}`
end

def wrap(s, width=80)
  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
end

def user_prompt(warning)
  STDOUT.puts ''
  STDOUT.puts "Type 'next' to view the next warning."
  STDOUT.puts "Type 'open' to open #{warning.relative_path} in an editor."
  STDOUT.puts "Type 'learn' to open #{warning.link} in a browser."
  STDOUT.puts "Type 'issue' to export this warning as a GitHub issue."
  STDOUT.puts ''
  input = STDIN.gets.strip
  input
end

def process_input(input, warning, warnings)
  if input == 'next'
    warnings.to_enum.next
  elsif input == 'issue'
    STDOUT.puts "Pretending to make a GitHub Issue..."
    input = user_prompt(warning)
    process_input(input, warning, warnings)
  elsif input == 'open'
    `open #{warning.file}`
    input = user_prompt(warning)
    process_input(input, warning, warnings)
  elsif input == 'learn'
    `open #{warning.link}`
    input = user_prompt(warning)
    process_input(input, warning, warnings)
  else
    STDOUT.puts 'Sorry, that command was invalid. Please try again.'
    process_input(input, warning, warnings)
  end
end

def interactive_warnings_iteration(warnings, params={})
  params[:type] = warnings unless params.has_key?(:type)
  warnings.each_with_index do |warning, i|
    STDOUT.puts ''
    STDOUT.puts "---------------------------"
    STDOUT.puts "Warning #{i+1}/#{warnings.length} (fingerprint: #{warning.fingerprint})"
    STDOUT.puts ''
    STDOUT.puts wrap(warning.to_s)
    STDOUT.puts ''
    STDOUT.puts "Visit #{warning.link} to learn more."
    input = user_prompt(warning)
    ctx = self
    process_input(input, warning, warnings)
  end
  STDOUT.puts ''
  STDOUT.puts "Finished checking #{params[:type]}."
  STDOUT.puts ''
end

namespace :security do  
  desc 'Finds security warnings (using the Brakeman gem)'
  
  task :models, [:min_confidence] => [:environment] do |t, args|
    desc 'Displays security warnings for models'
    min_confidence = DEFAULT_MIN_CONFIDENCE
    min_confidence = args[:min_confidence].to_i if args.has_key?(:min_confidence)
    checks = get_checks({min_confidence: min_confidence})
    model_warnings = checks.model_warnings
    interactive_warnings_iteration(model_warnings, {type: "Models"})
  end
  
  task :controllers, [:min_confidence] => [:environment] do |t, args|
    desc 'Displays security warnings for controllers'
    min_confidence = DEFAULT_MIN_CONFIDENCE
    min_confidence = args[:min_confidence].to_i if args.has_key?(:min_confidence)
    checks = get_checks({min_confidence: min_confidence})
    controller_warnings = checks.controller_warnings
    interactive_warnings_iteration(controller_warnings, {type: "Controllers"})
  end
  
  task :templates, [:min_confidence] => [:environment] do |t, args|
    desc 'Displays security warnings for templates'
    min_confidence = DEFAULT_MIN_CONFIDENCE
    min_confidence = args[:min_confidence].to_i if args.has_key?(:min_confidence)
    checks = get_checks({min_confidence: min_confidence})
    template_warnings = checks.template_warnings
    interactive_warnings_iteration(template_warnings, {type: "Templates"})
  end
  
  task :other, [:min_confidence] => [:environment] do |t, args|
    desc 'Displays other security warnings'
    min_confidence = DEFAULT_MIN_CONFIDENCE
    min_confidence = args[:min_confidence].to_i if args.has_key?(:min_confidence)
    checks = get_checks({min_confidence: min_confidence})
    warnings = checks.warnings
    interactive_warnings_iteration(warnings, {type: "Other"})
  end
  
  task :all => :environment do
    desc 'Displays all security warnings'
    checks = get_checks
  end
  
  
  
end