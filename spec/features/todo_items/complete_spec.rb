require 'spec_helper'

describe "Completing todo items" do
  let!(:todo_list){TodoList.create(title: "Groceries", description: "Grocery list.")}
  let!(:todo_item){todo_list.todo_item.create(content: "Milk")}

  it "is successful when marking a single item complete" do
    expect(todo_item.completed_at).to be_nil
    visit_todo_list todo_list
    within "#todo_item_#{todo_item.id}" do
      click_link "Mark Complete"
    end
    todo_item.reload
    expect(todo_item.completed_at).to_not be_nil
  end
end
