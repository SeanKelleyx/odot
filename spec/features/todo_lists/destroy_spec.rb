require 'spec_helper'

describe "Destroy todo lists" do 
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Grocery list.")}

	it "removes todo list item when the correct button is pressed" do
		expect(TodoList.count).to eq(1)
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end
		expect(TodoList.count).to eq(0)
	end

end