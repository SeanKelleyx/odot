require 'spec_helper'

describe "Adding todo items" do
  let!(:todo_list){TodoList.create(title: "Groceries", description: "Grocery list.")}
  let!(:todo_item){todo_list.todo_item.create(content: "Milk")}

  def visit_todo_list(list)
    visit "/todo_lists"

    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  def edit_todo_item(options={})
    options[:content] ||= "Lots of milk"
    
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: options[:content]
    click_button "Save"
  end

  it "edit spec is successful when content is valid" do 
    visit_todo_list todo_list
    edit_todo_item
    expect(page).to have_content("Saved todo list item.")
    todo_item.reload
    expect(todo_item.content).to eq("Lots of milk")
  end

  it "edit spec is unsuccessful with no content" do 
    visit_todo_list todo_list
    edit_todo_item content: ""
    expect(page).to have_content("Content can't be blank")
    todo_item.reload
    expect(todo_item.content).to eq("Milk")
  end

  it "edit spec is unsuccessful with content that is too short" do 
    visit_todo_list todo_list
    edit_todo_item content: "1"
    expect(page).to have_content("Content is too short")
    todo_item.reload
    expect(todo_item.content).to eq("Milk")
  end
end