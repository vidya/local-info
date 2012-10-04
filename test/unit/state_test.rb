#require 'test_helper'
#
#class StateTest < ActiveSupport::TestCase
#  # test "the truth" do
#  #   assert true
#  # end
#end

require 'test_helper'
#require "minitest/autorun"
#require "minitest-rails"

class StateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
#end


#class StateTest < MiniTest::Unit::TestCase
#  def test_sanity
#    puts "FROM test_sanity"
#    assert true
#    assert MiniTest::Rails::VERSION
    #binding.pry
    #true
  #end

  def test_includes_hawaii
    #puts "--- test_includes_hawaii"
    states = State.all.map { |st| st.name }
    states.must_include 'Hawaii'
  end

  def test_includes_sample_states
    #puts "--- test_includes_sample_states"
    sample_states = ['Hawaii', 'New Jersey', 'Kentucky', 'Wisconsin'].map { |st| st.downcase }
    all_states = State.all.map { |st| st.name.downcase }

    #binding.pry
    (sample_states - all_states).must_be_empty
  end
end
