%w(active_support active_record ap).each{|g| require g }
 
module Skills
  def main_skills
    {
      :programming_languages  => %w(Ruby Java PHP),
      :development_frameworks => %w(Rails JQuery Backbone.js Angular.js),
      :database               => %w(MySQL Oracle),
      :testing                => %w(Test::Unit MiniTest RSpec Shoulda FactoryGirl
                                    Cucumber Capybara  Selenium
                                    Guard),    
      :frontend               => %w(JavaScript HTML CSS),
      :frontend_frameworks    => %w(JQuery Backbone.js Bootstrap),
      :scm                    => %w(Git Subversion),
      :web_servers            => %w(Nginx Apache),
      :app_servers            => %w(Passenger Unicorn)
    }
  end
end
 
module Experience
  def self.included(base)
    class << base
      def experience
        jobs = []
 
        jobs << {
          :company  => "Oversee.net",
          :industry => "Online Travel ",  
          :roles    => ["Software Engineer", "Lead"],
          :when     => { :from => "2014/04", :to => Time.now }
        }
 
        jobs << {
          :company  => "AT&T Interactive",
          :industry => "Online Advertising",  
          :roles    => ["Software Engineer", "Data Developer"],
          :when     => { :from => "2012/03", :to => "2013/04"  }
        }
 
        jobs << {
          :company  => "Cadreon",
          :industry => "Online Advertising",  
          :roles    => ["Software Developer", "Lead Developer"],
          :when     => { :from => "2011/04", :to => "2012/03" }
        }

        jobs << {
          :company  => "ModCloth",
          :industry => "E-Commerce",  
          :roles    => ["Agile Rails Developer"],
          :when     => { :from => "2010/07", :to => "2011/03" }
        }

        jobs << {
          :company  => "PINC Solutions",
          :industry => "Software As A Service",  
          :roles    => ["Engineer"],
          :when     => { :from => "2008/06", :to => "2010/06" }
        }
 
        jobs
      end
    end
  end
end
 
class SaitMesutcanIlhaner < ActiveRecord::Base
 
  include Experience
  extend Skills
 
  has_one :passion,   :through => "computer science"
  has_many :skills,   :through => "experience", :include => "practice"
  has_many :projects, :through => "github", :foreign_key => "github.com/mesutcan"
 
  validates_presence_of :creative
  validates_presence_of :tdd
  validates_presence_of :pair_programming

 
  def self.contact
    `open http://mesutcanilhaner.com`
  end
 
  def self.inspect
    puts <<-END
 
    A passionate software engineer who strives to learn new things and get acquainted with new technologies everyday.
 
    END
  end
 
  def self.method_missing(method, *topics, &block)
    if method =~ /reference/
      raise StandardError, "Talk to me first!"
    else
      questions = ", specifically about #{topics.join(', ')}"
      puts "Got any questions on #{method}#{ questions unless topics.empty? }? " \
      " then contact me!"
      contact
    end
  end
 
end
