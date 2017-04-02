ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'rails/commands/server'


#http://stackoverflow.com/questions/27799260/rails-4-2-server-port-forwarding-on-vagrant-does-not-work
module Rails
  class Server
    new_defaults = Module.new do
      def default_options        
        default_host = Rails.env == 'development' ? '0.0.0.0' : '127.0.0.1'
        super.merge( Host: default_host )
      end
    end

    # Note: Module#prepend requires Ruby 2.0 or later
    prepend new_defaults
  end
end

#another solution
#https://fullstacknotes.com/make-rails-4-2-listen-to-all-interface/
=begin
module Rails  
  class Server
    alias :default_options_bk :default_options
    def default_options
      default_options_bk.merge!(Host: '0.0.0.0')
    end
  end
end  
=end