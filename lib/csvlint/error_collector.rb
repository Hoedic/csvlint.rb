module Csvlint
  
  module ErrorCollector
      
    def build_message(type, category, row, column, content, constraints)
      Csvlint::ErrorMessage.new({
                                  :type => type,
                                  :category => category,
                                  :row => row,
                                  :column => column,
                                  :content => content,
                                  :constraints => constraints
                                })
    end
    
    MESSAGE_LEVELS = [
      :errors,
      :warnings,
      :info_messages
    ]
    
    MESSAGE_LEVELS.each do |level|
      
      attr_reader level
      
      define_method "build_#{level}" do |type, category = nil, row = nil, column = nil, content = nil, constraints = {}|
        instance_variable_get("@#{level}") << build_message(type, category, row, column, content, constraints)
      end
      
    end
    
    def valid?
      errors.empty?
    end
    
    def reset
      MESSAGE_LEVELS.each do |level|
        instance_variable_set("@#{level}", [])
      end
    end
    
  end
end