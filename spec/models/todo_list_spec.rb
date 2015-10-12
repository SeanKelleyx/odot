require 'rails_helper'

RSpec.describe TodoList, type: :model do
  it { should have_many(:todo_item)}

  describe "#has_complete_items?" do
    let!(:todo_list){TodoList.create(title: "Groceries", description: "Grocery list.")}
    
    it "is false with no completed itmes" do
      todo_list.todo_item.create(content:"Eggs")
      expect(todo_list.has_completed_items?).to  be false
    end

    it "is true with completed todo items" do
      todo_list.todo_item.create(content:"Eggs", completed_at: 1.minutes.ago)
      expect(todo_list.has_completed_items?).to  be true
    end
  end


end
