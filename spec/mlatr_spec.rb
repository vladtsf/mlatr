require "mlatr"
require "exifr"

RSpec.describe Mlatr::Document do
  before(:all) do
    @fixtures_folder_path = 'spec/fixtures'
    @essay = Mlatr::Document.open(@fixtures_folder_path + '/essay.docx')
  end

  describe "thumbnail" do
    before do
      @thumbnail = EXIFR::JPEG.new @essay.thumbnail
    end

    it "should be 395x512" do
      expect(@thumbnail.width).to eq(395)
      expect(@thumbnail.height).to eq(512)
    end
  end

  describe "parse" do
    it 'the author should be "Vlad Tsvang"' do
      expect(@essay.author).to eq('Vlad Tsvang')
    end

    it 'the instructor should be "William Shakespeare"' do
      expect(@essay.instructor).to eq('William Shakespeare')
    end

    it 'the class_title should be "English 1A"' do
      expect(@essay.class_title).to eq('English 1A')
    end

    it 'the date should be "16 December 2014"' do
      expect(@essay.date).to eq('16 December 2014')
    end

    it 'the title should be "The Title of the Essay"' do
      expect(@essay.title).to eq('The Title of the Essay')
    end

    it 'the body should consist of the first five paragraphs of Lorem Ipsum' do
      lorem_ipsum = File.open(@fixtures_folder_path + "/lorem_ipsum.txt").read.strip
      expect(@essay.body).to eq(lorem_ipsum)
    end
  end
end