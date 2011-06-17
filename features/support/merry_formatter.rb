require 'cucumber/formatter/html'

require 'rubygems'

require 'erb'
begin
  require 'builder'
rescue LoadError
  gem 'builder'
  require 'builder'
end

module Merry
  class Html < ::Cucumber::Formatter::Html
    
    def initialize(step_mother, io, options)
      super(step_mother, io, options)
    end
    
    def visit_features(features)
      # <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      @builder.declare!(
        :DOCTYPE,
        :html, 
        :PUBLIC, 
        '-//W3C//DTD XHTML 1.0 Strict//EN', 
        'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'
      )
      @builder.html(:xmlns => 'http://www.w3.org/1999/xhtml') do
        @builder.head do
          @builder.title 'Specs'
          javascript
          inline_css
          charset_utf8
        end
        @builder.body do
          @builder.div(:class => 'cucumber') do
            #super
            features.accept(self)
          end
        end
      end
    end
    
    def visit_feature_name(name)
      lines = name.split(/\r?\n/)
      @builder.h2(lines[0].gsub(/Fonctionnalité: /, ''))
      @builder.p do
        lines[1..-1].each do |line|
          @builder.text!(line.strip)
          @builder.br
        end
      end
    end
    
    
    private
    
    def javascript
      @builder.script(:type => 'text/javascript') do
        @builder << (File.read(RAILS_ROOT + '/public/javascripts/jquery.js'))
        @builder << (File.read(File.dirname(__FILE__) + '/merry_javascript.js'))    
      end      
      
    end
    
    def charset_utf8
      @builder << "<meta http-equiv='Content-Type' content='text/html;charset=UTF-8' />"
    end

    def inline_css
      @builder.style(:type => 'text/css') do
        @builder.text!(File.read(File.dirname(__FILE__) + '/merry_cucumber.css'))
      end
    end
    
  end
end
