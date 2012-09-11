
describe ZipCode do
  it "should have more than 30,000 entries in the database" do
   #binding.pry
   assert  ZipCode.count > 30000, 'zip_codes table has less than 30,000 entries'
  end

  it "should have less than 40,000 entries in the database" do
   puts "===> zip_code db: entry count = #{ZipCode.count}"
   assert ZipCode.count < 40000, 'zip_codes table has more than 40,000 entries'
  end

  it "should have zip codes for Rhode Island" do
   zip_codes_from_ri = ZipCode.select(:state_code).all.select { |zc| zc.state_code.eql? 'RI'}

   assert zip_codes_from_ri.size > 0, 'does not contain zip codes from Rhode Island'
  end
end
