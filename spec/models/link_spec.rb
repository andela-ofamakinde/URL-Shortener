require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe Link, type: :model do
  it 'should create a Link with valid parameters' do
    link1 = Link.create(long_url: 'http://www.google.com',short_url: 'qwe6')
    link2 = Link.create(long_url: 'https://www.google.com',short_url: 'eba2')
    link3 = Link.create(long_url: 'www.twitter.com',short_url: 'oi12')

    expect(link1).to be_valid
    expect(link2).to be_valid
  end
  it 'should not create a Link with invalid parameters' do
    link4 = Link.create(long_url: 'www.',short_url: '011e')
    link5 = Link.create(long_url: 'hhhht',short_url: '0924')
    link6 = Link.create(long_url: 'www.google',short_url: 'qery')

    expect(link4).not_to be_valid
    expect(link5).not_to be_valid
    expect(link6).not_to be_valid
  end
end
