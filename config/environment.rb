require 'rubygems'
require 'bundler/setup'
require 'hanami/setup'
require 'hanami/assets'
require_relative '../apps/web/application'

Hanami::Container.configure do
  mount Web::Application, at: '/'
end

Hanami::Assets.configure do
  compile true
  sources << ['assets']
end
