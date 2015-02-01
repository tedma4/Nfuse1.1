require 'spec_helper'

describe Shout do

  # Associations
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many(:comments) }

  describe 'Class itself' do
    it 'sets up constant' do
      expect(Shout).to have_constant(:YT_LINK_FORMAT)
      expect(Shout::YT_LINK_FORMAT).to be_a Regexp
    end
  end

  describe 'Validations' do
    let(:shout) { build(:shout_with_picture) }
    it { is_expected.to validate_presence_of(:user_id) }

    context 'shouts that are not valid' do
      it 'Not an image' do
        expect{ 
          @invalid_shout = build(:shout, pic: "#{Rails.root.to_s}/spec/factories/images/one.txt") 
          }.to raise_error
      end
      it 'No image' do
        expect(build(:shout, pic: nil)).to be_valid
        expect(build(:shout, snip: nil)).to be_valid
      end

      it 'needs a user' do
        expect(build(:shout, user: nil)).not_to be_valid
      end
    end

    it '#set_content_type' do
      types = ["image/jpg", "image/jpeg", "image/png" ]

      expect(shout.pic_content_type).not_to be_nil
      expect(types).to include(shout.pic_content_type)
      expect(shout.pic_file_name).not_to be_nil
      expect(shout.is_video?).to be_falsy
      shout.save
      expect(shout.is_pic?).to be_truthy

    end
    it 'checks '
  end
end
