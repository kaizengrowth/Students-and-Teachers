require_relative 'spec_helper'

describe Teacher do
  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:teachers)
  end

  describe '#email' do
    let(:user) { User.new(email: "user@example.com") }
    context 'when is not unique' do
      let(:another_user) { User.new(email: "user@example.com") }
      before { another_user.save }
      it 'should will raise an error' do
        expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email has already been taken")
      end
    end
    context 'when is empty' do

    end
  end

  context '#age' do

  end

  context '#name and #age' do
    before(:each) do
      @teacher = Teacher.new
      @teacher.assign_attributes(
        name: 'Alex',
        email: 'alex@lighthouselabs.ca',
        address: '439 Yonge Street',
        phone: '4168392049'
      )
    end

    it 'should be a unique email address' do
      [:email].{ |method| expect(@student).to respond_to(method) }
    end
  end

  context 'validations' do
    before(:each) do
      @student = Student.new
      @student.assign_attributes(
        first_name: 'Kreay',
        last_name: 'Shawn',
        birthday: Date.new(1989, 9, 24),
        gender: 'female',
        email: 'kreayshawn@oaklandhiphop.net',
        phone: '(510) 555-1212 x4567'
      )
    end

    it 'should accept valid info' do
      expect(@student).to be_valid
    end

    it "shouldn't accept invalid emails" do
      ['XYZ!bitnet', '@.', 'a@b.c'].each do |address|
        @student.assign_attributes(email: address)
        expect(@student).to_not be_valid
      end
    end

    it 'should accept valid emails' do
      ['joe@example.com', 'info@bbc.co.uk', 'bugs@facebook.com'].each do |address|
        @student.assign_attributes(email: address)
        expect(@student).to be_valid
      end
    end

    it "shouldn't accept toddlers" do
      @student.assign_attributes(birthday: Date.today - 3.years)
      expect(@student).to_not be_valid
    end

    it "shouldn't allow two students with the same email" do
      Student.create!(
        birthday: @student.birthday,
        email: @student.email,
        phone: @student.phone
      )
      expect(@student).to_not be_valid
    end
  end
end
