require 'spec_helper'

describe 'user' do
  describe user(ENV['SSH_USER_NAME']) do
    it { should exist }
    it { should have_login_shell '/bin/bash' }
    it { should belong_to_group 'wheel' }
    it { should have_authorized_key File.read(ENV['SSH_PUBLIC_KEY_FULL_PATH']).strip }
  end
end
