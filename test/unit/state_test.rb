describe State do
  it "should return CA as code for California" do
    st = State.find_by_name 'California'

    st.code.must_equal 'CA'
  end

  it "should include sample states" do
    sample_states = ['Hawaii', 'New Jersey', 'Kentucky', 'Wisconsin'].map { |st| st.downcase }
    all_states = State.all.map { |st| st.name.downcase }

    (sample_states - all_states).must_be_empty
  end
end
