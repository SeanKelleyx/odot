require 'rails_helper'

describe "Adding todo items" do
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Grocery list.")}

	def visit_todo_list(list)
		visit "/todo_lists"

		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end

	def create_todo_item(options={})
		options[:content] ||= "Milk"
		
		click_link "New Todo Item"
		fill_in "Content", with: options[:content]
		click_button "Save"
	end

	it "is successful with valid content" do 
		visit_todo_list(todo_list)
		create_todo_item
		expect(page).to have_content("Added todo list item.")
		within "ul.todo_items" do 
			expect(page).to have_content("Milk")
		end
	end

	it "displays an error when there is no content" do
		visit_todo_list(todo_list)
		create_todo_item content: ""
    within "div.flash" do 
		  expect(page).to have_content("There was a problem adding that todo list item")
		end
    expect(page).to have_content("Content can't be blank")
		expect(todo_list.todo_item.count).to eq(0)
	end

  it "displays an error when content is too short" do
    visit_todo_list(todo_list)
    create_todo_item content: "1"
    within "div.flash" do 
      expect(page).to have_content("There was a problem adding that todo list item")
    end
    expect(page).to have_content("Content is too short")
    expect(todo_list.todo_item.count).to eq(0)
  end

end