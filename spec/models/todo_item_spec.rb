require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  it { should belong_to(:todo_list)}

  describe "#completed?" do
    let!(:todo_item){TodoItem.create(content: "Hello")}

    it "is false when completed at is blank" do
      todo_item.completed_at=nil
      expect(todo_item.completed?).to  be false
    end

    it "is true when completed at is not blank" do
      todo_item.completed_at=Time.now
      expect(todo_item.completed?).to  be true
    end
  end

end
