require 'spec_helper'

describe "Deleting todo items" do
  let(:user){create(:user)}
  let!(:todo_list){user.todo_lists.create(title: "Groceries", description: "Grocery list.")}
  let!(:todo_item){todo_list.todo_item.create(content: "Milk")}

  before do
    sign_in user, password: "tester1"
  end

  it "deleting todo list items is successfull" do
    expect(TodoItem.count).to eq(1)
    visit_todo_list todo_list
    within "#todo_item_#{todo_item.id}" do
      click_link "Delete"
    end
    expect(page).to have_content("Todo list item was successfully deleted.")
    expect(TodoItem.count).to eq(0)
  end

end
