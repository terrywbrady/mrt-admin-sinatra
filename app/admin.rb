# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require_relative 'lib/routes/home'
require_relative 'lib/routes/code'
require_relative 'lib/routes/resources'
require_relative 'lib/routes/query'

set :bind, '0.0.0.0'

include Sinatra::UC3HomeRoutes
include Sinatra::UC3CodeRoutes
include Sinatra::UC3ResourcesRoutes
include Sinatra::UC3QueryRoutes

AdminUI::TopMenu.instance.create_menu_item_for_path(
  AdminUI::MENU_HOME,
  AdminUI::MENU_ROOT,
  'Admin Tool Home'
)
get '/' do
  erb :index,
    :layout => :page_layout,
    :locals => {
      context: AdminUI::Context.new(request.path)
    }
end

AdminUI::TopMenu.instance.create_menu_item_for_path(
  AdminUI::MENU_HOME,
  '/context',
  'Admin Tool Context'
)
get '/context' do
  erb :table,
    :layout => :page_layout,
    :locals => {
      context: AdminUI::Context.new(request.path),
      table: UC3::UC3Client.new.context
    }
end

AdminUI::TopMenu.instance.create_menu_item_for_path(
  AdminUI::MENU_HOME,
  '/clients',
  'Admin Tool Clients'
)
get '/clients' do
  UC3Code::SourceCodeClient.new
  UC3Resources::InstancesClient.new
  UC3Resources::ParametersClient.new
  UC3Resources::BucketsClient.new
  UC3Resources::FunctionsClient.new
  UC3Resources::LoadBalancerClient.new
  UC3Query::QueryClient.client

  erb :table,
    :layout => :page_layout,
    :locals => {
      context: AdminUI::Context.new(request.path),
      table: UC3::UC3Client.new.client_list
    }
end
