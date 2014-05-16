require 'spec_helper'

describe Keyword do
  describe "after create with a keyword with the name 'example'" do
    let(:keyword)           { FactoryGirl.create(:keyword, name: 'example') }
    let(:returned_synonyms) { ["illustration", "instance", "representative",
              "model", "exemplar", "good example", "deterrent example",
              "lesson", "object lesson", "case", "exercise", "admonition",
              "happening", "ideal", "information", "internal representation",
              "mental representation", "monition", "natural event",
              "occurrence", "occurrent", "representation", "warning",
              "word of advice"] }

    before do
      BigHugeThesaurus.stub(:synonyms).and_return(returned_synonyms)
    end

    it "sets a metaphone of 'equal'" do
      keyword.metaphone.should eq(["AKSM", nil])
    end

    it "set an array synonyms of 'example'" do
      keyword.synonyms.should eq(returned_synonyms)
    end
  end
end
