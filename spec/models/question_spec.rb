require 'rails_helper'
require 'spec_helper'

RSpec.describe Question, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
end

describe Question do
  let (:user) {User.create(username: 'jay', email: 'jay@j.com', password: 'abc')}
  let (:question) {Question.create(user_id: user.id, url: "http://www.w.com", title: "Title")}
  let (:answer) { Answer.create(question_id: question.id, user_id: user.id, content: "Content", accepted: false)}

  context "validations" do
      it { should validate_presence_of :user_id }
      it { should validate_presence_of :url}
      it { should validate_presence_of :title}
    end

  context "associations" do
      it "should have a votes collection" do
        expect(question.votes).to be_empty
      end

      it "should have a voters collection" do
        expect(question.voters).to be_empty
      end 

      it "should have an answers collection" do
        expect(question.answers).to be_empty
      end

      it "should have a comments collection" do
        expect(question.comments).to be_empty
      end

    end

    context "#reset_all_answers" do
      it "should change accepted field on all answers to 'false'" do
        answer.update(accepted: true)
        question.reset_all_answers
        expect(answer.reload.accepted).to be false
      end
    end

    context "#best" do
      it "should return the accepted answer" do
        answer.update(accepted: true)
        expect(question.reload.best).to eq(answer)
      end

      it "should return nil if no accepted answer" do
        expect(question.best).to be nil
      end
    end

    context "elapsed" do
      pending
    end
end
