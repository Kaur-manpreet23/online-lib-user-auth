require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(
      email: 'hi@hello.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    expect(user).to be_valid
  end

  it 'validates uniqueness of email' do
    user1 = User.create(
      email: 'a@b.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    user2 = User.new(
      email: 'a@b.com',
      password: 'password456',
      password_confirmation: 'password456'
    )
    expect(user2).not_to be_valid
  end

  it 'is invalid with password not equal to password_confirmation' do
    user = User.new(
      email: 'hi@hello.com',
      password: 'password123',
      password_confirmation: 'password'
    )
    expect(user).not_to be_valid
  end
end
