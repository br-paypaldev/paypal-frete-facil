# encoding: utf-8
require 'rubygems'
require 'rake'
require './lib/paypal/fretefacil/version'

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "paypal-frete-facil"
  gem.homepage = "http://github.com/prodis/paypal-frete-facil"
  gem.license = "MIT"
  gem.summary = %Q{Cálculo de frete do Frete Fácil do PayPal.}
  gem.description = %Q{Cálculo de frete utilizando o Web Service do Frete Fácil do PayPal.}
  gem.email = "prodis@gmail.com"
  gem.authors = ["Prodis a.k.a. Fernando Hamasaki"]
  gem.version = PayPal::FreteFacil::Version::VERSION
  gem.required_ruby_version = ">= 1.9"
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "paypal-frete-facil #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
