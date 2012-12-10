module NeighborhoodHelper
  class Neighborhood
    include ActiveModel::Validations

    validates_presence_of :street_address, :city, :state, :zipcode

    attr_accessor :street_address, :city, :state, :zipcode

    def initialize(params)
      @street_address     = params['street_address']
      @city               = params['city']
      @state              = params['state']
      @zipcode            = params['zipcode']

      puts "@street_address = #{@street_address}"
    end

    def city_state
      "98765========#{@city}---#{@state}"
    end
  end
end

#a = Person.new("Fred", nil)
#a.valid? # => false
#a.last_name = "Flintstone"
#a.valid? # => true