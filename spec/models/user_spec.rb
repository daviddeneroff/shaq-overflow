require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
end

describe User do
    let (:user) {User.create(username: 'jay', email: 'jay@j.com', password: 'abc')}
    
    context "validations" do
      it { should validate_presence_of :email }
      it { should validate_presence_of :username}
      it { should validate_presence_of :password_digest}
      

      # it { should validate_uniqueness_of :email }
      # it { should validate_uniqueness_of(:username) }
      # see https://github.com/thoughtbot/shoulda-matchers/issues/459

    end
    
    context "associations" do
      it "should have a questions collection" do
        expect(user.questions).to be_empty
      end

      it "should have an answer collection" do
        expect(user.answers).to be_empty
      end 

      it "should have a votes collection" do
        expect(user.votes).to be_empty
      end

      it "should have a comments collection" do
        expect(user.comments).to be_empty
      end

    end

end



