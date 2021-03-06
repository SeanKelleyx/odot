require 'spec_helper'
require_relative 'helper'

describe "Editing todo lists" do 
	let(:todo_list){create(:todo_list)}

	def edit_todo_list(options={})
		options[:title] ||= "New Title"
		options[:description] ||= "New Description"

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"

		todo_list.reload
	end

	before do
		sign_in todo_list.user, password: "tester1"
	end

	it "updates a todo list item successfully with correct information" do
		edit_todo_list
		
		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New Title")
		expect(todo_list.description).to eq("New Description")
	end

	it "displays an error when updating but the todo list title is empty" do
		edit_todo_list title: ""

		expect(page).to have_content("error")
		visit "/todo_lists"

		expect(todo_list.title).to eq("Groceries")
		expect(todo_list.description).to eq("Grocery list.")
	end

	it "displays an error when updating but the todo list title is too short" do
		edit_todo_list title: "Hi"

		expect(page).to have_content("error")
		visit "/todo_lists"

		expect(todo_list.title).to eq("Groceries")
		expect(todo_list.description).to eq("Grocery list.")
	end

	it "displays an error when updating but the todo list description is empty" do
		edit_todo_list description: ""

		expect(page).to have_content("error")
		visit "/todo_lists"

		expect(todo_list.title).to eq("Groceries")
		expect(todo_list.description).to eq("Grocery list.")
	end

	it "displays an error when updating but the todo list description is too short" do
		edit_todo_list description: "Desc"

		expect(page).to have_content("error")
		visit "/todo_lists"

		expect(todo_list.title).to eq("Groceries")
		expect(todo_list.description).to eq("Grocery list.")
	end
end