require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "valhalla"
    s.summary = %Q{TODO}
    s.email = "andy@foxsoft.co.uk"
    s.homepage = "http://github.com/andyh/valhalla"
    s.description = "A collection of tasks for automating TYPO3"
    s.authors = ["Andy Henson"]
    s.default_executable = %q{typo3}
    s.executables = ["typo3"]
    s.files = FileList["[A-Z]*.*", "{bin,generators,lib,test,spec}/**/*"]
    s.add_dependency 'erubis', '>= 2.6.2'
    s.add_dependency 'rake', '>= 0.8.3'
    s.add_dependency 'mysql', '>= 2.7'
    s.add_dependency 'wycats-thor', '>= 0.9.8'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'valhalla'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new

task :default => :rcov
