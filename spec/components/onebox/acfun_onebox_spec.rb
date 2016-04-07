require 'spec_helper'
load File.expand_path('../../../helpers.rb', __FILE__)

describe Onebox::Engine::AcfunOnebox do
  before do
    FakeWeb.register_uri(:get, 'http://www.acfun.tv/v/ac2650705', body: response('acfun'), content_type: 'text/html')
  end

  it 'returns object as the placeholder' do
    expect(Onebox.preview('http://www.acfun.tv/v/ac2650705')
        .placeholder_html).to match(/object/)
  end
end
