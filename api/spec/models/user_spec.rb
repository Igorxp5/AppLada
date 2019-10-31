require 'rails_helper'

RSpec.describe User, type: :model do
    describe "user" do
        before(:all) do
            DatabaseCleaner.clean_with(:deletion)
        end
        
        it "valid create user" do
            test_user = User.new({
                login: "username_teste",
                email: "username_teste@teste.com",
                password: "senha_teste",
                name: "Testador Do Time",
                birthday: "30/01/2000", 
                gender: "M"
            })
            
            expect(test_user).to be_valid
        end
        
        it "empty login" do
            test_user = User.new({
                login: "",
                email: "username_teste@teste.com",
                password: "senha_teste",
                name: "Testador Do Time",
                birthday: "30/01/2000", 
                gender: "M"
            })
            
            expect(test_user).not_to be_valid
        end
        
        it "empty email" do
            test_user = User.new({
                login: "username_teste",
                email: "",
                password: "senha_teste",
                name: "Testador Do Time",
                birthday: "30/01/2000", 
                gender: "M"
            })
            
            expect(test_user).not_to be_valid
        end
        
        it "empty password" do
            test_user = User.new({
                login: "username_teste",
                email: "username_teste@teste.com",
                password: "",
                name: "Testador Do Time",
                birthday: "30/01/2000", 
                gender: "M"
            })
            
            expect(test_user).not_to be_valid
        end
        
        it "empty name" do
            test_user = User.new({
                login: "username_teste",
                email: "username_teste@teste.com",
                password: "senha_teste",
                name: "",
                birthday: "30/01/2000", 
                gender: "M"
            })
            
            expect(test_user).not_to be_valid
        end
        
        it "empty birthday" do
            test_user = User.new({
                login: "username_teste",
                email: "username_teste@teste.com",
                password: "senha_teste",
                name: "Testador Do Time",
                birthday: "", 
                gender: "M"
            })
            
            expect(test_user).not_to be_valid
        end
        
        it "empty gender" do
            test_user = User.new({
                login: "username_teste",
                email: "username_teste@teste.com",
                password: "senha_teste",
                name: "Testador Do Time",
                birthday: "30/01/2000", 
                gender: ""
            })
            
            expect(test_user).not_to be_valid
        end
    end
end