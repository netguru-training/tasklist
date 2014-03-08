require 'spec_helper'

describe ListsController do
	let(:valid_attributes) { {name: 'MyList'} }
	let(:user) { User.create(name: 'User', email: 'user@example.com', uid: 'uid') }
	before { controller.stub(:current_user).and_return(user) }

	describe "GET show" do
		let!(:my_list) { user.lists.create(valid_attributes) }

		it "shows the list for given id" do
			get :show, { id: my_list.to_param }
			expect(controller.list).to eq my_list
		end
	end

	describe "POST create" do

		it "shows the list for given id" do
			post :create,  list: valid_attributes
			expect(controller.list.name).to eq 'MyList'
		end

		it "assigns the list to the current_user" do
			post :create,  valid_attributes
			expect(controller.list.user).to eq user
		end
	end

end