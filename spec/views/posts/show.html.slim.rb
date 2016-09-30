require 'rails_helper'

describe 'posts/show.html.slim', type: :view do
  it 'renders' do
    expect(subject).to be_instance_of String
  end
end
