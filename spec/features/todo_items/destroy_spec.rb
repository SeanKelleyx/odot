require 'spec_helper'

describe "Deleting todo items" do
  let!(:todo_list){TodoList.create(title: "Groceries", description: "Grocery list.")}
  let!(:todo_item){todo_list.todo_item.create(content: "Milk")}

  def visit_todo_list(list)
    visit "/todo_lists"

    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
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
