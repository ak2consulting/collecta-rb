require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'collecta-rb'
    gem.summary = %Q{A ruby library based on Blather for working with the Collecta XMPP api.}
    gem.description = %Q{A ruby library based on Blather for working with the Collecta XMPP api.}
    gem.email = "sprsquish@gmail.com"
    gem.homepage = "http://github.com/sprsquish/collecta-rb"
    gem.authors = ["Jeff Smick"]

    gem.add_dependency "blather"

    gem.add_development_dependency "minitest"
    gem.add_development_dependency "yard"

    gem.files = FileList['examples/**/*', 'lib/**/*'].to_a

    gem.test_files = FileList['spec/**/*.rb']
  end
  Jeweler::GemcutterTasks.new
  task :release => 'gemcutter:release'
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'spec'
  test.pattern = 'spec/**/*_spec.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'spec'
    test.pattern = 'spec/**/*_spec.rb'
    test.rcov_opts += ['--exclude \/Library\/Ruby,spec\/', '--xrefs']
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
