require 'spec_helper'
require 'rack/test'

describe Shout do

  # Associations
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many(:comments) }

  describe 'Class itself' do
    it 'sets up constant' do
      # expect(Shout).to have_constant(:YT_LINK_FORMAT)
      # expect(Shout::YT_LINK_FORMAT).to be_a Regexp
    end
  end

  describe 'Validations' do
    let(:shout) { 
      Shout.new(user_id: create(:user).id,
                pic: Rack::Test::UploadedFile.new("#{Rails.root.to_s}/spec/factories/images/one.jpg", 'image/jpg'),
                content: 'Not sure what needs to go here - assuming a string.' ) 
    }

    let(:invalid_shout) {
      Shout.new()
    }
    it { is_expected.to validate_presence_of(:user_id) }

    context 'shouts that are not valid' do
      it 'Not an image' do
        expect{ 
          Shout.new(user_id: create(:user).id, pic: "#{Rails.root.to_s}/spec/factories/images/one.txt") 
          }.to raise_error
      end
      it 'No image' do
        expect(shout).to be_valid
        expect(shout).to be_valid
      end

      it 'needs a user' do
        expect(invalid_shout).not_to be_valid
      end
    end

    it '#set_content_type' do
      types = ["image/jpg", "image/jpeg", "image/png" ]

      expect(shout.pic_content_type).not_to be_nil
      expect(types).to include(shout.pic_content_type)
      expect(shout.pic_file_name).not_to be_nil
      expect(shout.is_video?).to be_falsy
      expect(shout).to be_valid

      shout.save()
      shout.reload
      expect(shout.is_pic?).to be_truthy

    end
    it 'checks '
  end
end
