require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TodoItemsHelper. For example:
#
# describe TodoItemsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end


def visit_todo_list(list)
  visit "/todo_lists"

  within dom_id_for list do
    click_link "List Items"
  end
end

def dom_id_for(model)
  ["#",ActionView::RecordIdentifier.dom_id(model)].join
end



RSpec.describe TodoItemsHelper, type: :helper do
 
end
