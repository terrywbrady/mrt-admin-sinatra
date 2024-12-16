require 'sinatra/base'
require_relative '../client/code/source_code'
require_relative '../ui/context'

require 'sinatra/base'

# custom sinatra routes
module Sinatra
  # client specific routes
  module UC3CodeRoutes

    def self.registered(app)
      srccode = UC3Code::SourceCodeClient.new

      app.get '/' do
        status 200
  
        erb :index,
          :layout => :page_layout,
          :locals => {
            context: AdminUI::Context.new('Merritt Admin Tool - UC3 Account', top_page: true),
            repos: srccode.repos.keys
          }
      end
  
      app.get '/git/*' do |repo|
        erb :git,
        :layout => :page_layout,
        :locals => {
          context: AdminUI::Context.new("Repo Tags: #{srccode.reponame(repo)}"),
          table: srccode.repo_tags(repo)
        }
      end
    end
  end
  register UC3CodeRoutes
end
