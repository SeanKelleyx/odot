require 'spec_helper'

describe "Viewing todo items" do
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Grocery list.")}

	it "displays the list title on list items page" do 
		visit_todo_list(todo_list)
		within("h1") do
			expect(page).to have_content(todo_list.title)
		end
	end

	it "displays no items when an list is empty" do 
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(0)
	end

	it "displays content when there are items in a list" do
		todo_list.todo_item.create(content: "Eggs")
		todo_list.todo_item.create(content: "Bacon")
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(2)
		within "ul.todo_items" do
			expect(page).to have_content("Eggs")
			expect(page).to have_content("Bacon")
		end
	end
end 