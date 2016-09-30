require 'rails_helper'

describe PostsHelper, type: :helper do
  describe '#markdown' do
    context 'when valid markdown' do
      let(:text) { '**This** _is_ an [example](http://example.org/).' }

      it 'parses into html' do
        expect(helper.markdown(text))
          .to match '<p><strong>This</strong> <em>is</em> an'
      end
    end

    context 'when valid markdown with newlines' do
      let(:text) { "Headline\n===" }

      it 'parses into html' do
        expect(helper.markdown(text)).to match '<h1>Headline</h1>'
      end
    end
  end
end
